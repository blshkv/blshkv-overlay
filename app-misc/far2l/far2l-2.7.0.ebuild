# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CMAKE_MAKEFILE_GENERATOR ?= ninja
#CMAKE_MAKEFILE_GENERATOR=emake
#CMAKE_IN_SOURCE_BUILD=1
#CMAKE_VERBOSE=ON
#CMAKE_BUILD_TYPE=Release

PYTHON_COMPAT=( python3_{11..13} )

WX_GTK_VER="3.2-gtk3"

inherit cmake xdg wxwidgets

DESCRIPTION="Linux port of FAR Manager v2"
HOMEPAGE="https://github.com/elfmz/far2l"
SRC_URI="https://github.com/elfmz/far2l/archive/refs/tags/v_${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-v_${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="+archive +chardet +colorer nfs samba sftp +ssl webdav wxwidgets X"
RESTRICT="mirror"

RDEPEND="
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	X? (
		x11-libs/libX11
		x11-libs/libXi
	)
	archive? (
		app-arch/libarchive
	)
	chardet? ( app-i18n/uchardet )
	colorer? ( dev-libs/libxml2 )
	nfs? ( net-fs/libnfs )
	samba? ( net-fs/samba )
	sftp? ( net-libs/libssh[sftp] )
	ssl? ( dev-libs/openssl )
	webdav? ( net-libs/neon )"

DEPEND="${RDEPEND}"

DOCS=( README.md )

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
}

src_prepare() {
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_askpass)::" \
		-i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_sudoapp)::" \
		-i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/.*::" \
		-i "${S}"/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	#FIXME: more options:
	# -DPYTHON=yes
	#ALIGN AUTOWRAP CALC COMPARE DRAWLINE EDITCASE EDITORCOMP FARFTP
	#FILECASE INCSRCH INSIDE MULTIARC NETROCKS SIMPLEINDENT TMPPANEL
	local mycmakeargs=(
		-DUSEWX="$(usex wxwidgets)"
		-DUSEUCD=$"$(usex chardet)"
		-DCOLORER="$(usex colorer)"
#		FIXME: add python plugins support
#		-DPYTHON="$(usex python)"
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
	einstalldocs
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_askpass"
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_sudoapp"
}
