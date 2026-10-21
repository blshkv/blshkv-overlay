# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
PYTHON_REQ_USE="ssl"
inherit linux-info optfeature python-single-r1 systemd xdg

# waydroid commit the NVIDIA patch is applied against
_WAYDROID_SHA="a33a5c0b31d89d6ce687381104b30aff4dd2d330"

DESCRIPTION="Waydroid with full NVIDIA GPU acceleration via Mesa Venus/vtest"
HOMEPAGE="https://github.com/Shiro836/waydroid-nvidia"
SRC_URI="
	https://github.com/Shiro836/waydroid-nvidia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/waydroid/waydroid/archive/${_WAYDROID_SHA}.tar.gz -> waydroid-${_WAYDROID_SHA:0:8}.tar.gz
	https://github.com/Shiro836/waydroid-nvidia/releases/download/v${PV}/waydroid-nvidia-host-x86_64-v${PV}.tar.zst -> ${P}-host-x86_64.tar.zst
	https://github.com/Shiro836/waydroid-nvidia/releases/download/v${PV}/waydroid-nvidia-guest-android-x86_64-v${PV}.tar.zst -> ${P}-guest-android.tar.zst
	https://github.com/Shiro836/waydroid-nvidia/releases/download/v${PV}/waydroid-nvidia-guest-prebuilts-v${PV}.tar.zst -> ${P}-guest-prebuilts.tar.zst
"

S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="apparmor"

# Conflicts: provides the same waydroid binary (patched for NVIDIA)
RDEPEND="${PYTHON_DEPS}
	!app-containers/waydroid
	app-containers/lxc[apparmor?,seccomp]
	dev-libs/expat
	x11-libs/libdrm
	media-libs/libepoxy
	media-libs/mesa
	media-libs/vulkan-loader
	net-firewall/nftables
	net-dns/dnsmasq[dhcp]
	sys-devel/binutils
	sys-apps/dbus
	sys-auth/polkit
	virtual/notification-daemon
	x11-libs/gtk+:3[introspection,wayland]
	x11-libs/libX11
	x11-themes/hicolor-icon-theme
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		>=dev-python/gbinder-1.3.0[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	|| (
		media-video/pipewire[sound-server]
		media-sound/pulseaudio-daemon
	)
"
BDEPEND="app-arch/zstd"

# Pre-built host (virglrenderer) and guest (Android Mesa/ANGLE/HWC) binaries
RESTRICT="strip"
QA_PREBUILT="
	usr/lib/waydroid-nvidia/virgl_test_server
	usr/lib/waydroid-nvidia/virgl_render_server
	usr/lib/waydroid-nvidia/libvirglrenderer.so.1
	usr/lib/waydroid-nvidia/guest/*
"

CONFIG_CHECK="
	~ANDROID_BINDER_IPC
	~ANDROID_BINDERFS
	~MEMFD_CREATE
	~NETFILTER_XT_TARGET_MASQUERADE
	~NETFILTER_XT_NAT
	~PSI
	~!PSI_DEFAULT_DISABLED
	~NF_TABLES
	~NF_TABLES_INET
	~NF_TABLES_NETDEV
	~NFT_NUMGEN
	~NFT_NAT
	~NFT_TUNNEL
	~NFT_QUOTA
	~NFT_SOCKET
	~NF_FLOW_TABLE
	~NFT_BRIDGE_META
	~NFT_BRIDGE_REJECT
	~UDMABUF
"
ERROR_UDMABUF="CONFIG_UDMABUF: needed for /dev/udmabuf — the Venus gralloc allocates CPU-mappable buffers through it"

pkg_setup() {
	linux-info_pkg_setup
	python-single-r1_pkg_setup
}

src_unpack() {
	unpack "${P}.tar.gz"
	unpack "waydroid-${_WAYDROID_SHA:0:8}.tar.gz"
	mkdir -p "${WORKDIR}/host" "${WORKDIR}/guest" || die
	# Android-relative paths in the tarballs require explicit extraction dirs
	tar -C "${WORKDIR}/host" -xf "${DISTDIR}/${P}-host-x86_64.tar.zst" || die
	tar -C "${WORKDIR}/guest" -xf "${DISTDIR}/${P}-guest-android.tar.zst" || die
	tar -C "${WORKDIR}/guest" -xf "${DISTDIR}/${P}-guest-prebuilts.tar.zst" || die
}

src_prepare() {
	local waydroid_src="${WORKDIR}/waydroid-${_WAYDROID_SHA}"

	pushd "${waydroid_src}" > /dev/null || die
	eapply "${S}/patches/waydroid/0001-nvidia-integration.patch"
	if ! use apparmor; then
		# https://github.com/waydroid/waydroid/issues/652
		sed -e '/^lxc\.apparmor\.profile =/d' \
			-i data/configs/config_3 || die
	fi
	popd > /dev/null || die

	default
}

src_install() {
	local waydroid_src="${WORKDIR}/waydroid-${_WAYDROID_SHA}"
	local pkg_aur="${S}/packaging/aur/waydroid-nvidia-bin"

	# 1. Patched waydroid (same layout as app-containers/waydroid)
	pushd "${waydroid_src}" > /dev/null || die
	python_fix_shebang waydroid.py
	local mymakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}"/usr
		SYSD_DIR="$(systemd_get_systemunitdir)"
		USE_NFTABLES=1
		USE_SYSTEMD=1
	)
	emake "${mymakeargs[@]}" install install_apparmor
	popd > /dev/null || die

	newinitd "${FILESDIR}/waydroid.initd" waydroid

	# 2. Host Venus renderer (private libdir; wd-venus.service sets LD_LIBRARY_PATH)
	exeinto /usr/lib/waydroid-nvidia
	doexe "${WORKDIR}"/host/virgl_test_server "${WORKDIR}"/host/virgl_render_server \
		"${WORKDIR}"/host/libvirglrenderer.so.1

	# 3. Guest driver stack — preserve Android-relative lib/lib64 paths
	local guest_libs=(
		vendor/lib/hw/vulkan.virtio.so
		vendor/lib/egl/libEGL_angle.so
		vendor/lib/egl/libGLESv1_CM_angle.so
		vendor/lib/egl/libGLESv2_angle.so
		vendor/lib64/hw/vulkan.virtio.so
		vendor/lib64/egl/libEGL_angle.so
		vendor/lib64/egl/libGLESv1_CM_angle.so
		vendor/lib64/egl/libGLESv2_angle.so
		vendor/lib64/libgbm_mesa_wrapper.so
		vendor/lib64/hw/hwcomposer.waydroid.so
	)
	local rel
	for rel in "${guest_libs[@]}"; do
		insinto "/usr/lib/waydroid-nvidia/guest/${rel%/*}"
		doins "${WORKDIR}/guest/${rel}"
	done
	exeinto /usr/lib/waydroid-nvidia/guest/system/bin
	doexe "${WORKDIR}"/guest/system/bin/surfaceflinger

	# 4. Host integration
	systemd_douserunit "${pkg_aur}/wd-venus.service"
	dobin "${pkg_aur}/waydroid-nvidia-setup"
	insinto /usr/lib/udev/rules.d
	newins "${pkg_aur}/waydroid-nvidia.rules" 70-waydroid-nvidia.rules
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "After installation:"
	elog "  1. Initialize waydroid:     waydroid init"
	elog "  2. Run the NVIDIA setup:    sudo waydroid-nvidia-setup"
	elog "  3. Enable the container:    rc-service waydroid start"
	elog "  4. Start the Venus server:  systemctl --user enable --now wd-venus"
	elog "  5. Start the session:       waydroid session start"
	elog
	elog "Requirements: nvidia-open kernel modules + nvidia_drm.modeset=1"
	elog "See https://github.com/Shiro836/waydroid-nvidia for full documentation"
	elog
	if use apparmor; then
		ewarn "Check the known issues for apparmor:"
		ewarn "https://docs.waydro.id/debugging/known-issues"
	fi

	optfeature "clipboard support" "dev-python/pyclip[wayland]"
	optfeature "NVIDIA proprietary driver (required for GPU acceleration)" "x11-drivers/nvidia-drivers"
}

pkg_config() {
	"${EROOT}"/usr/bin/waydroid init
}
