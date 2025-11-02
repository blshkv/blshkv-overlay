# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="library to create maps using tiles from a map provider"
HOMEPAGE="https://wrobell.dcmod.org/geotiler/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
#IUSE="test"
RESTRICT="test"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/cytoolz-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-2.3.5[${PYTHON_USEDEP}]
"

#BDEPEND="
#	test? (
#		dev-python/mypy[${PYTHON_USEDEP}]
#		dev-python/pytest-cov[${PYTHON_USEDEP}]
#		dev-python/pytest-timeout[${PYTHON_USEDEP}]
#		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
#		dev-python/numpy[${PYTHON_USEDEP}]
#	)"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
