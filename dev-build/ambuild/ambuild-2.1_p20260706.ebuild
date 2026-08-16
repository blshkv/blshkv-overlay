# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

GITHUB_REPOSITORY="alliedmodders/ambuild"
GITHUB_COMMIT="d89ec91a7ac2607da07b50bb62346f9a10e9a998"

inherit distutils-r1 github-archive

DESCRIPTION="AlliedModders C++ Build System"
HOMEPAGE="https://github.com/alliedmodders/ambuild"
#SRC_URI="https://github.com/alliedmodders/ambuild/archive/refs/tags/${PV}-distutils.tar.gz -> ${P}.gh.tar.gz"
#S="${WORKDIR}/${P}-distutils"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#RDEPEND=""
#DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#RESTRICT="test"
#distutils_enable_tests pytest

#src_prepare() {
#	eapply "${FILESDIR}/${PN}-2.1-remove-imp.patch"
#	distutils-r1_src_prepare
#}
