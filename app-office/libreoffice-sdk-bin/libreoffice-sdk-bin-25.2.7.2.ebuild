# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

MY_P="LibreOffice_${PV}_Linux_x86-64_rpm_sdk"
MY_MV="$(ver_cut 1-2)"

DESCRIPTION="LibreOffice SDK"
HOMEPAGE="https://www.libreoffice.org"
SRC_URI="https://downloadarchive.documentfoundation.org/libreoffice/old/${PV}/rpm/x86_64/${MY_P}.tar.gz"
#SRC_URI="https://download.documentfoundation.org/libreoffice/stable/${PV}/rpm/x86_64/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

QA_PREBUILT=opt/libreoffice${MY_MV}/sdk/bin/*

RDEPEND="|| ( =app-office/libreoffice-${MY_MV}* =app-office/libreoffice-bin-${MY_MV}* )"
DEPEND="${RDEPEND}"

src_unpack(){
	unpack ${A}
	rpm_unpack ./${MY_P}/RPMS/libobasis${MY_MV}-sdk-${PV}-2.x86_64.rpm
}

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR ./opt "${ED}"/ || die "Failed to copy files"
}
