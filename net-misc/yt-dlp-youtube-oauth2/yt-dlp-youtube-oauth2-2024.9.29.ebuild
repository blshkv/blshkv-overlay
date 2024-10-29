# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="yt-dlp plugin that adds OAuth2 login support"
HOMEPAGE="https://github.com/coletdjnz/yt-dlp-youtube-oauth2"
SRC_URI="https://github.com/coletdjnz/yt-dlp-youtube-oauth2/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

#RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
