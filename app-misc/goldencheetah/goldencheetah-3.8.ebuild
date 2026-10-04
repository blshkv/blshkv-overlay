# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="GoldenCheetah/GoldenCheetah"
inherit github-archive qmake-utils desktop

DESCRIPTION="Performance Software for Cyclists, Runners, Triathletes and Coaches"
HOMEPAGE="https://www.goldencheetah.org/ ${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +oauth"

RDEPEND="sys-devel/flex
	sys-devel/bison

	dev-qt/qtbase:6

	dev-qt/qtwebengine:6
	dev-qt/qtcharts:6
	dev-qt/qtserialport:6
	dev-qt/qtpositioning:6
	dev-qt/qtsvg:6
	dev-qt/qt5compat:6
	dev-qt/qtbase[widgets]
	dev-qt/qtmultimedia:6
	dev-qt/qtconnectivity:6
	x11-libs/qwt:6

	virtual/glu
	sci-libs/gsl
	dev-libs/libical

	oauth? ( net-libs/liboauth )
"

DEPEND="${RDEPEND}"

#2. ADDING OPTIONAL DEPENDENCIES
#   - FTDI D2XX
#   - SRMIO
#   - libkml
#   - libvlc  - Video playback in training mode
#   - libusb  - If you want support for using USB2 sticks in Train View
#   - R       - If you want R charts
#   - Python  - If you want Python charts, scripts and data processors

src_prepare() {
	cp qwt/qwtconfig.pri.in qwt/qwtconfig.pri
	cp src/gcconfig.pri.in src/gcconfig.pri

	# See INSTALL-LINUX
	if use debug; then
		sed -i '/CONFIG += debug/s/^#//g' src/gcconfig.pri
	else
		sed -i '/CONFIG += release/s/^#//g' src/gcconfig.pri
	fi
	sed -i '/GSL_INCLUDES = \/usr\/include/s/^#//g' src/gcconfig.pri
	sed -i '/GSL_LIBS = -lgsl/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_LRELEASE/s/^#//g' src/gcconfig.pri
	sed -i 's|/usr/bin/lrelease|/usr/lib64/qt6/bin/lrelease|g' src/gcconfig.pri
	sed -i '/QMAKE_CXXFLAGS/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_LEX  = flex/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_YACC = bison/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_MOVE = cp/s/^#//g' src/gcconfig.pri
	sed -i '/LIBZ_INCLUDE/s/^#//g' src/gcconfig.pri
	sed -i '/LIBZ_LIBS/s/^#//g' src/gcconfig.pri

	# Enable pkg-config and add mandatory libical; append oauth when USE=oauth
	sed -i '/CONFIG.*link_pkgconfig/s/^#//g' src/gcconfig.pri
	local pkgs="libical"
	use oauth && pkgs+=" oauth"
	sed -i "s|^#*PKGCONFIG =.*|PKGCONFIG = ${pkgs}|" src/gcconfig.pri

	eapply "${FILESDIR}/${P}-pr4924-ltmsidebar-overlap.patch"
	eapply_user
}

src_configure() {
	eqmake6 -recursive
}

src_compile() {
	emake
}

src_install() {
	newbin src/GoldenCheetah goldencheetah
	make_desktop_entry ${PN} "GoldenCheetah" goldencheetah.png "Science;Sports;"
	doicon "${FILESDIR}"/goldencheetah.png
}
