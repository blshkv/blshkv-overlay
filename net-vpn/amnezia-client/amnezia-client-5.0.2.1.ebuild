# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SFPM_COMMIT="f2881493e42bd7b7d5b7abe804dad084dd610b71"

inherit cmake desktop xdg

DESCRIPTION="VPN client that resists DPI detection and censorship"
HOMEPAGE="https://amnezia.org"

SRC_URI="
	https://github.com/amnezia-vpn/amnezia-client/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/mitchcurtis/SortFilterProxyModel/archive/${SFPM_COMMIT}.tar.gz -> SortFilterProxyModel-${SFPM_COMMIT}.gh.tar.gz
"

S="${WORKDIR}/amnezia-client-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64"

DEPEND="
	dev-libs/openssl:=
	dev-libs/qtkeychain:=
	net-libs/libssh:=
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets,xml]
	dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	dev-qt/qtremoteobjects:6
	dev-qt/qtsvg:6
	dev-qt/qttools:6
"
RDEPEND="${DEPEND}
	dev-qt/qtshadertools:6
"
BDEPEND="dev-qt/qttools:6"


src_unpack() {
	default

	rmdir "${S}/client/3rd/SortFilterProxyModel" || die
	mv "${WORKDIR}/SortFilterProxyModel-${SFPM_COMMIT}" \
		"${S}/client/3rd/SortFilterProxyModel" || die
}

src_prepare() {
	cmake_src_prepare
	eapply "${FILESDIR}/${P}-no-conan.patch"
	eapply "${FILESDIR}/${P}-system-libs.patch"
	eapply "${FILESDIR}/${P}-odr-fix.patch"
	sed -i 's|"../client/3rd/qtkeychain/qtkeychain/keychain\.h"|<qt6keychain/keychain.h>|' \
		client/secureQSettings.h || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/client/AmneziaVPN" amnezia-vpn

	doicon "${S}/deploy/data/linux/AmneziaVPN.png"
	make_desktop_entry amnezia-vpn "Amnezia VPN" AmneziaVPN "Network;VPN"
}
