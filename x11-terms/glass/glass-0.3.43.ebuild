# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GLYPH_PV="0.5.0"

DESCRIPTION="Terminal emulator in x86_64 Linux assembly, speaks X11 wire protocol directly"
HOMEPAGE="https://github.com/isene/glass"
SRC_URI="
	https://github.com/isene/glass/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/isene/glyph/archive/refs/tags/v${GLYPH_PV}.tar.gz -> glyph-${GLYPH_PV}.gh.tar.gz
"
S="${WORKDIR}/glass-${PV}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="-* amd64"

BDEPEND="dev-lang/nasm"
RDEPEND="media-fonts/font-misc-misc"

src_unpack() {
	default
	# glass.asm does: %include "../glyph/glyph.asm"
	mv "${WORKDIR}/glyph-${GLYPH_PV}" "${WORKDIR}/glyph" || die
}

src_compile() {
	emake glass
}

src_install() {
	dobin glass
}
