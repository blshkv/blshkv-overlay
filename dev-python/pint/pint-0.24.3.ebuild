# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN="Pint"
#PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://pint.readthedocs.io https://github.com/hgrecco/pint"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="babel numpy test uncertainties"

RDEPEND="${DEPEND}
	numpy? ( dev-python/numpy[${PYTHON_USEDEP}] )
	uncertainties? ( dev-python/uncertainties[${PYTHON_USEDEP}] )
	babel? ( dev-python/babel[${PYTHON_USEDEP}] )

	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/flexcache[${PYTHON_USEDEP}]
	dev-python/flexparser[${PYTHON_USEDEP}]
"

#pandas = ["pint-pandas >= 0.3"]
#xarray = ["xarray"]
#dask = ["dask"]
#mip = ["mip >= 1.13"]


RESTRICT="!test? ( test )"

distutils_enable_tests pytest

#src_prepare () {
#	default
#	sed -i "s/PACKAGE_VERSION/${PV}/" ${S}/${PN}/__init__.py
#}
