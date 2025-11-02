# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="Cython implementation of Toolz: High performance functional utilities"
HOMEPAGE="https://github.com/pytoolz/cytoolz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#FIXME
# https://github.com/pytoolz/cytoolz/issues/204
# cytoolz-0.12.3/cytoolz/_signatures.py
# from toolz._signatures import *
RDEPEND=" >=dev-python/toolz-0.8.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

#distutils_enable_tests pytest

python_compile() {
	# --without-cython
	distutils-r1_python_compile -j1
}
