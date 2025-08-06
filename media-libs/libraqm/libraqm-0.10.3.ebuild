# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A library for complex text layout"
HOMEPAGE="https://github.com/HOST-Oman/libraqm"
SRC_URI="https://github.com/HOST-Oman/libraqm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~x64-macos"
IUSE="gtk-doc"

# Option: SheenBidi can be used instead of Fribidi
RDEPEND="
	media-libs/freetype:2
	media-libs/harfbuzz:=
	dev-libs/fribidi
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	gtk-doc? ( dev-util/gtk-doc )
"

src_configure() {
	local emesonargs=(
		$(meson_use gtk-doc docs)
	)
	meson_src_configure
}
