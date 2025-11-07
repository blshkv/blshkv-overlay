# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Django FileResponse that adds Content-Range headers"
HOMEPAGE="https://github.com/wearespindle/django-ranged-fileresponse https://django-filter.readthedocs.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
