# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/google/jax/archive/refs/tags/jax-v0.4.25.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
#KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

S=${WORKDIR}/jax-jax-v0.4.25/jaxlib/
