# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="MySQL driver written in Python"
HOMEPAGE="https://github.com/onegreyonewhite/pytimeparse2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
RESTRICT="test"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"
