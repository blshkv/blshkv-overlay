# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit desktop

MY_PN="${PN/-client-bin/_client}"
MY_P=${MY_PN}-v${PV}-linux-x86_64

DESCRIPTION="Command-line client for TrustTunnel"
HOMEPAGE="https://trusttunnel.org/ https://github.com/TrustTunnel/TrustTunnelClient"
SRC_URI="https://github.com/TrustTunnel/TrustTunnelClient/releases/download/v${PV}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

# https://github.com/TrustTunnel/TrustTunnelClient/blob/master/DEVELOPMENT.md#building

src_install() {
	insinto /usr/share/${MY_PN}
	doins -r ${MY_PN}
	doins -r "${FILESDIR}"/trusttunnel_client.toml

	fperms +x /usr/share/${MY_PN}/${MY_PN}
	dosym -r /usr/share/${MY_PN}/${MY_PN} /usr/bin/trusttunnel

#	doicon ${FILESDIR}/trusttunnel.png
#	make_desktop_entry trusttunnel "Trust Tunnel" /usr/share/pixmaps/trusttunnel.png "Network;System"
}
