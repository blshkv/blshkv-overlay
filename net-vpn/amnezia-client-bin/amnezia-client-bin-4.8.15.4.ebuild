# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="amnezia"
inherit unpacker desktop

DESCRIPTION="VPN services and protocols that resist DPI detection"
HOMEPAGE="https://amnezia.org/starter-guide"
SRC_URI="https://github.com/amnezia-vpn/amnezia-client/releases/download/${PV}/AmneziaVPN_${PV}_linux_x64.tar"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="amd64"

RDEPEND="dev-libs/libayatana-appindicator"

RESTRICT="bindist mirror"
QA_PREBUILT="*"

# binwalk, 7z dec OFFSET +1
src_unpack() {

	unpack ${A}
	MY_A="${A%.*}.7z"
	tail -c +28046178 "${WORKDIR}"/AmneziaVPN_Linux_Installer.bin > ${MY_A} || die
	unpack_7z ${MY_A}
	rm -f AmneziaVPN_Linux_Installer.bin
	rm -f ${MY_A} || die

#	unpack_makeself AmneziaVPN_Linux_Installer.bin 28046178 tail

}

#src_install() {
#	insinto /usr/share/${MY_PN}
#	doins -r usr/share/${MY_PN}/*
#	fperms +x /usr/share/hiddify/{hiddify,HiddifyCli}

#	dosym -r /usr/share/${MY_PN}/hiddify /usr/bin/hiddify
#	dosym -r /usr/share/${MY_PN}/HiddifyCli /usr/bin/hiddifyCli

#	doicon usr/share/icons/hicolor/128x128/apps/hiddify.png
#	make_desktop_entry hiddify "Hiddify" /usr/share/pixmaps/hiddify.png "Network;System"
#}

