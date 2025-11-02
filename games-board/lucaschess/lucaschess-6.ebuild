# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

#inherit distutils-r1
inherit python-r1

DESCRIPTION="Lucas Chess R Version 2"
HOMEPAGE="https://github.com/lukasmonk/lucaschessR6"
#SRC_URI="https://github.com/lukasmonk/lucaschessR2/archive/refs/tags/R2.18c.tar.gz"
#SRC_URI=""
#S="${WORKDIR}/lucaschessR2-R${PV}c"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/chardet-3.0.4[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/chess-0.28.3[${PYTHON_USEDEP}]
	>=dev-python/pillow-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyside-6.0.0[multimedia,${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.20[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/polib-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/deep-translator-1.11.4[${PYTHON_USEDEP}]

	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.0.7[${PYTHON_USEDEP}]
	>=dev-python/idna-2.10[${PYTHON_USEDEP}]
	>=dev-python/certifi-2024.2.2[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-1.10.0[${PYTHON_USEDEP}]
	dev-python/audioop-lts[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
