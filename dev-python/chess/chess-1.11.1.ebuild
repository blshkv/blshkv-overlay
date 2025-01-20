# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Chess library for Python, with move generation, move validation, and support for common formats"
HOMEPAGE="https://pypi.org/project/chess/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
