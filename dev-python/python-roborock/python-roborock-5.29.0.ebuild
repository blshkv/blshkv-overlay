# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3_11 python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="A package to control Roborock vacuums"
HOMEPAGE="https://github.com/python-roborock/python-roborock https://pypi.org/project/python-roborock/"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="amd64 ~arm64"
IUSE="+cli"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND=">=dev-python/aiohttp-3.8.2[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.18.0[${PYTHON_USEDEP}]
	>=dev-python/paho-mqtt-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/construct-2.10.57[${PYTHON_USEDEP}]
	>=dev-python/protobuf-6.31.1[${PYTHON_USEDEP}]
	dev-python/vacuum-map-parser-roborock[${PYTHON_USEDEP}]
	>=dev-python/pyrate-limiter-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/aiomqtt-2.5.0[${PYTHON_USEDEP}]
	cli? ( dev-python/click[${PYTHON_USEDEP}]
		dev-python/click-shell[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/pyshark[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest
