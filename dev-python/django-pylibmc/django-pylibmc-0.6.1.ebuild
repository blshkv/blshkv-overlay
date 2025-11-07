# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Django cache backend using pylibmc"
HOMEPAGE="https://pypi.org/project/django-pylibmc/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="dev-python/pylibmc[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
