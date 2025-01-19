# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit pypi
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
#pypi

DESCRIPTION="Composable transformations of Python+NumPy programs"
HOMEPAGE="https://jax.readthedocs.io/en https://github.com/jax-ml/jax"
SRC_URI="https://github.com/jax-ml/jax/archive/refs/tags/jax-v${PV}.tar.gz -> ${P}.gh.tar.gz"
S=${WORKDIR}/jax-jax-v${PV}/jaxlib/

LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/ml-dtypes-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.26.0[${PYTHON_USEDEP}]
	dev-python/opt-einsum[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.11.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
