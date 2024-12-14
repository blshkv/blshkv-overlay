# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV//_rc/-RC}"
inherit qmake-utils

HASH_COMMIT="fa2402f4b26dacb20dc58e24f5c7119bdb896666"

DESCRIPTION="Performance Software for Cyclists, Runners, Triathletes and Coaches"
HOMEPAGE="https://www.goldencheetah.org/ https://github.com/GoldenCheetah/GoldenCheetah"
SRC_URI="https://github.com/GoldenCheetah/GoldenCheetah/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="qt6"
KEYWORDS="amd64"
IUSE="+oauth"

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

	virtual/opengl
	sci-libs/gsl

	oauth? ( net-libs/liboauth )
"

DEPEND="${RDEPEND}"

#2. ADDING OPTIONAL DEPENDENCIES
#   - FTDI D2XX
#   - SRMIO
#   - liboauth
#   - libkml
#   - libvlc  - Video playback in training mode
#   - libical - Diary window and CalDAV support (external calendar integration)
#   - libusb  - If you want support for using USB2 sticks in Train View
#   - R       - If you want R charts
#   - Python  - If you want Python charts, scripts and data processors

S="${WORKDIR}"/GoldenCheetah-${HASH_COMMIT}

src_prepare() {
	cp qwt/qwtconfig.pri.in qwt/qwtconfig.pri
	cp src/gcconfig.pri.in src/gcconfig.pri

	# See INSTALL-LINUX
	sed -i '/CONFIG += release/s/^#//g' src/gcconfig.pri
	sed -i '/GSL_INCLUDES = \/usr\/include/s/^#//g' src/gcconfig.pri
	sed -i '/GSL_LIBS = -lgsl/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_LRELEASE/s/^#//g' src/gcconfig.pri
	sed -i 's|/usr/bin/lrelease|/usr/lib64/qt5/bin/lrelease|g' src/gcconfig.pri
	sed -i '/QMAKE_CXXFLAGS/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_LEX  = flex/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_YACC = bison/s/^#//g' src/gcconfig.pri
	sed -i '/QMAKE_MOVE = cp/s/^#//g' src/gcconfig.pri
	sed -i '/LIBZ_INCLUDE/s/^#//g' src/gcconfig.pri
	sed -i '/LIBZ_LIBS/s/^#//g' src/gcconfig.pri
	eapply_user
}

src_configure() {
	eqmake6 -recursive
}
src_compile() {
	eqmake6 -recursive
	emake
}

src_install() {
	newbin src/GoldenCheetah goldencheetah-"${SLOT}"
}
