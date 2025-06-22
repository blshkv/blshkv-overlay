# Copyright 2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

MY_PV="${PV}-50070"
DESCRIPTION="Manage Synology NAS: share printers, set up WoL, and configure network drives"
HOMEPAGE="https://kb.synology.com/en-nz/DSM/help/Assistant/assistant?version=7
	https://www.synology.com/en-nz/releaseNote/Assistant"
SRC_URI="https://global.synologydownload.com/download/Utility/Assistant/${MY_PV}/Ubuntu/x86_64/synology-assistant_${MY_PV}_amd64.deb?model=DS1621%2B&bays=6&dsm_version=7.2.2&build_number=72806 -> ${P}.deb"

S=${WORKDIR}

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

QA_PREBUILT="opt/Synology/SynologyAssistant/SynologyAssistant.bin
	opt/Synology/SynologyAssistant/lib/*
	opt/Synology/SynologyAssistant/platforms/*
"
src_unpack(){
	unpack_deb ${A}
	rm -r ./usr/share/doc
}

src_install(){
	cp -pPR "${S}"/{opt,usr} "${D}"/ || die "Failed to copy /opt files"
	dosym "${EPREFIX}"/opt/Synology/SynologyAssistant/SynologyAssistant /usr/bin/SynologyAssistant
}
