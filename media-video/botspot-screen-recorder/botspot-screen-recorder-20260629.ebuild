# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="Botspot/botspot-screen-recorder"
GITHUB_COMMIT="14d8f53dd6c7681e781790fd3d24a07767064195"

inherit github-archive desktop

DESCRIPTION="Simple screen recording tool for wlroots-based Wayland compositors"
HOMEPAGE="https://github.com/Botspot/botspot-screen-recorder"

KEYWORDS="~amd64 ~arm64 ~x86"
SLOT="0"

RDEPEND="
	media-video/ffmpeg
	media-video/mpv
	gui-apps/slurp
	media-libs/libv4l
	gui-apps/wf-recorder
	gui-apps/wlr-randr
	gnome-extra/yad
	gnome-extra/yad
"

src_install() {
	insinto /usr/share/${PN}
	doins webcam-view.lua
	domenu ${FILESDIR}/bsr.desktop
	exeinto /usr/share/${PN}
	doexe screen-recorder.sh
	dosym -r  /usr/share/${PN}/screen-recorder.sh /usr/bin/${PN}
}
