# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="GUI framework on top of aiogram"
HOMEPAGE="https://github.com/Tishka17/aiogram_dialog"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="proxy fast"

RESTRICT="test"

RDEPEND="
	>=dev-python/aiogram-3.0[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/cachetools-4.0[${PYTHON_USEDEP}]
	dev-python/magic-filter[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
