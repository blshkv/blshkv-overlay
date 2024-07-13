# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

MY_P="${PN}_cupswrapper_GPL_source_${PV}-0"

DESCRIPTION="Brother's MFC-9140CDN CUPS wrapper"
HOMEPAGE="http://support.brother.com/g/s/id/linux/en/download_prn.html#MFC-9140CDN"
SRC_URI="${MY_P}.tar.gz"
#http://support.brother.com/g/b/downloadend.aspx?c=eu_ot&lang=en&prod=mfc9140cdn_eu_as_cn&os=127&dlid=dlf100408_000&flang=4&type3=576

LICENSE="GNU-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="net-print/cups
	net-print/mfc9140cdnlpr"

S=${WORKDIR}/"${MY_P}"

src_compile() {
	cd brcupsconfpt1
	emake
}

src_install() {
	exeinto /usr/libexec/cups/filter/
	doexe "${FILESDIR}"/brother_lpdwrapper_mfc9140cdn

	exeinto /opt/brother/Printers/mfc9140cdn/cupswrapper/
	doexe brcupsconfpt1/brcupsconfpt1

	insinto /usr/share/cups/model/Brother/
	doins PPD/brother_mfc9140cdn_printer_en.ppd
}

