# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Nearby Share implementation for Linux"
HOMEPAGE="https://github.com/vicr123/QNearbyShare"

QTZEROCONF_COMMIT="473d8520f954d22f8ad45e0d9a945c97b7282264"

SRC_URI="
	https://github.com/vicr123/QNearbyShare/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/jbagg/QtZeroConf/archive/${QTZEROCONF_COMMIT}.tar.gz -> QtZeroConf-473d8520.tar.gz
"

S="${WORKDIR}/QNearbyShare-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="+openssl"

RDEPEND="
	dev-qt/qtbase:6[dbus,network]
	dev-libs/protobuf:=
	dev-cpp/abseil-cpp:=
	net-dns/avahi
	openssl? ( dev-libs/openssl:= )
	!openssl? ( dev-libs/crypto++:= )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	# The GitHub source tarball contains an empty QtZeroConf submodule placeholder;
	# remove it so the mv below replaces it rather than nesting inside it.
	rmdir "${S}/libqnearbyshare-server/QtZeroConf" || die
	mv "${WORKDIR}/QtZeroConf-${QTZEROCONF_COMMIT}" \
		"${S}/libqnearbyshare-server/QtZeroConf" || die

	# https://github.com/vicr123/QNearbyShare/pull/19
	eapply "${FILESDIR}/${P}-openssl-fixes.patch"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DUSE_OPENSSL=$(usex openssl ON OFF)
	)
	cmake_src_configure
}
