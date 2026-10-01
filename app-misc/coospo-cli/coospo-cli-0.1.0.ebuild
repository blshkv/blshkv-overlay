# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="COOSPO CS500/CS600 bike computer CLI: FIT file download over Bluetooth LE"
HOMEPAGE="https://github.com/blshkv/coospo-cli https://pypi.org/project/coospo-cli/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/bleak-0.22[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
