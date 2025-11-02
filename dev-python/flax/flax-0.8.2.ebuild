# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="A neural network library for JAX designed for flexibility"
HOMEPAGE="https://github.com/google/flax"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=""
#	>=dev-python/numpy-1.19.5[${PYTHON_USEDEP}]
#"
#    "numpy>=1.22",
#    "numpy>=1.23.2; python_version>='3.11'",
#    "numpy>=1.26.0; python_version>='3.12'",
#    "jax>=0.4.19",
#    "msgpack",
#    "optax",
#    "orbax-checkpoint",
#    "tensorstore",
#    "rich>=11.1",
#    "typing_extensions>=4.2",
#    "PyYAML>=5.4.1",

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
