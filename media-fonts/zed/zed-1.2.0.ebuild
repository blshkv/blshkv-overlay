# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

# based on Iosevka, Noto
DESCRIPTION="The Zed Mono typeface, custom built from Iosevka"
HOMEPAGE="https://github.com/zed-industries/zed-fonts"
SRC_URI="https://github.com/zed-industries/zed-fonts/releases/download/${PV}/zed-mono-${PV}.zip
	https://github.com/zed-industries/zed-fonts/releases/download/${PV}/zed-sans-${PV}.zip"
S=${WORKDIR}

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~riscv x86"

BDEPEND="app-arch/unzip"

FONT_S="${S}"
FONT_SUFFIX="ttf"

FONT_CONF=(
	"${FILESDIR}/66-zed-mono.conf"
	"${FILESDIR}/66-zed-sans.conf"
)
