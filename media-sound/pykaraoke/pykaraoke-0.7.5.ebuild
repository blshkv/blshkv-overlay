# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )
inherit desktop distutils-r1

DESCRIPTION="PyKaraoke is a free karaoke player"
HOMEPAGE="http://kibosh.org/pykaraoke/index.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mutagen"

DEPEND=""
RDEPEND="dev-python/pygame
	dev-python/wxpython
	media-libs/sdl-mixer[timidity]
	media-libs/libsdl
	mutagen? ( media-libs/mutagen )"

src_prepare() {
	eapply "${FILESDIR}/${PN}-custom_pattern.patch"
	eapply_user
}

src_install() {
	distutils_src_install
	newicon icons/pykaraoke.xpm ${PN}.xpm
}
