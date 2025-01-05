# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player"
HOMEPAGE="http://code.google.com/p/sopcast-player/"
SRC_URI="https://github.com/sopcast-player/sopcast-player/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

RDEPEND="dev-python/pygtk
	dev-python/pygobject
	net-p2p/sopcast-bin
	media-video/vlc
	sys-devel/gettext"

DEPEND="${REPEND}
	dev-lang/python[sqlite]"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install \
	|| die "emake install failed"
	dosym /usr/bin/sopcast-bin /usr/bin/sp-sc
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
