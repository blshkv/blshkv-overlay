# Copyright 2026 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

GITHUB_REPOSITORY="c0deJedi/nbd-vram"
GITHUB_COMMIT="e2f1144f93c6f508b01a2ff435509e27853c0632"

inherit toolchain-funcs systemd udev github-archive

DESCRIPTION="Use your NVIDIA GPU's VRAM as swap space on Linux via NBD"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

# libcuda.so is dlopened at runtime from nvidia-drivers
RDEPEND="
	virtual/udev
	sys-block/nbd
	x11-drivers/nvidia-drivers
	systemd? ( sys-apps/systemd )
	!systemd? ( virtual/cron )
"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -o nbd-vram nbd-vram.c ${LDFLAGS} -ldl -lpthread || die
}

src_install() {
	# Service files reference /usr/local/bin — fix to /usr/bin for Gentoo FHS
	sed -i 's|/usr/local/bin/|/usr/bin/|g' systemd/*.service || die

	# Main daemon and init-system-agnostic helpers
	dobin nbd-vram
	dobin nbd-vram-connect.sh
	dobin nbd-vram-disconnect.sh

	if use systemd; then
		dobin nbd-vram-sleep.sh
		dobin nbd-vram-power-check.sh

		systemd_dounit systemd/vram-swap-nbd.service
		systemd_dounit systemd/vram-swap-nbd-suspend.service
		systemd_dounit systemd/nbd-vram-power-check.service
		systemd_dounit systemd/nbd-vram-battery-watch.service
		systemd_dounit systemd/nbd-vram-battery-watch.timer

		udev_dorules udev/99-nbd-vram-power.rules
	else
		# nbd-vram-power-check.sh is called directly by udev and cron
		dobin "${FILESDIR}/nbd-vram-power-check.sh"

		doinitd "${FILESDIR}/nbd-vram-swap.initd"
		doconfd "${FILESDIR}/nbd-vram-swap.confd"

		# Sleep hook for elogind (suspend/resume)
		insinto /lib/elogind/system-sleep
		newins "${FILESDIR}/nbd-vram-sleep.sh" nbd-vram
		fperms 0755 /lib/elogind/system-sleep/nbd-vram

		# Battery watch via cron (replaces nbd-vram-battery-watch.timer)
		insinto /etc/cron.d
		newins "${FILESDIR}/nbd-vram.cron" nbd-vram

		# Udev rule: call script directly, no systemctl
		udev_dorules "${FILESDIR}/99-nbd-vram-power-openrc.rules"
	fi

	# Runtime config (protected by CONFIG_PROTECT; user edits are preserved)
	insinto /etc
	doins nbd-vram.conf

	einstalldocs
}

pkg_postinst() {
	elog "To use nbd-vram, ensure your Linux kernel has NBD support enabled:"
	elog "  Device Drivers --->"
	elog "    [*] Block devices --->"
	elog "      <M>   Network block device support"
	elog ""

	if use systemd; then
		elog "Edit VRAM_SETUP_SIZE_MB in /etc/systemd/system/vram-swap-nbd.service"
		elog "to set how much VRAM to dedicate to swap before enabling the service."
		elog ""
		elog "To start automatically on boot:"
		elog "  systemctl enable --now vram-swap-nbd"
	else
		elog "Edit VRAM_SETUP_SIZE_MB in /etc/conf.d/nbd-vram-swap"
		elog "to set how much VRAM to dedicate to swap before enabling the service."
		elog ""
		elog "To start automatically on boot:"
		elog "  rc-update add nbd-vram-swap default"
		elog "  rc-service nbd-vram-swap start"
	fi

	udev_reload
}

pkg_postrm() {
	udev_reload
}
