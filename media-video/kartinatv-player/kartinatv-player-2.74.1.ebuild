# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="KartinaTV Player"
HOMEPAGE="https://www.kartina.tv/article/143-download-kartinatv-player"
SRC_URI="amd64? ( http://firmware.kartina.tv/pc/linux/kartina_tv_${PV}_20171118_amd64.rpm )"
RESTRICT="mirror strip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-arch/rpm2targz"
RDEPEND="dev-qt/assistant:4"

src_unpack() {
	#create a proper $S directory
	mkdir -p "${S}"
	cd "${S}"
	rpm_unpack
}

src_install() {
	cp -pPR . "${ED}"/
}
