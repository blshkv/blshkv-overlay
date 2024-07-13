# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm pax-utils

DESCRIPTION="Brother's proprietary MFC-9140CDN printer driver"
HOMEPAGE="https://support.brother.com/g/b/downloadhowto.aspx?c=sg&lang=en&prod=mfc9140cdn_eu_as_cn&os=127&dlid=dlf100404_000&flang=4&type3=558"
SRC_URI="mfc9140cdnlpr-1.1.2-1.i386.rpm"
LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pax_kernel"

RDEPEND="net-print/cups"

QA_PRESTRIPPED="/usr/bin/brprintconf_mfc9140cdn /opt/brother/Printers/mfc9140cdn/lpd/brmfc9140cdnfilter"
QA_FLAGS_IGNORED="/usr/bin/brprintconf_mfc9140cdn /opt/brother/Printers/mfc9140cdn/lpd/brmfc9140cdnfilter"

S=${WORKDIR}

src_unpack() {
	rpm_src_unpack ${A}
	cd "${S}"
}

src_install() {
	if use pax_kernel; then
		pax-mark m usr/bin/brprintconf_mfc9140cdn
	fi

	insinto /opt
	doins -r opt/brother
	fperms +x /opt/brother/Printers/mfc9140cdn/lpd/*

	dobin usr/bin/brprintconf_mfc9140cdn
}
