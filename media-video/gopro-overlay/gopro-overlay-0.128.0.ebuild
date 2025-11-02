# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYPI_PN=${PN/-/_}

PYTHON_COMPAT=( python3_{13..14} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

#gopro_overlay-0.128.0.tar.gz

DESCRIPTION="GoPro MP4 & Generic GPX/FIT files and create video dashboards & maps"
HOMEPAGE="https://github.com/time4tea/gopro-dashboard-overlay"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	>=dev-python/pillow-10.1.0[raqm,${PYTHON_USEDEP}]
	>=dev-python/pint-0.22[${PYTHON_USEDEP}]
	>=dev-python/geotiler-0.15[${PYTHON_USEDEP}] <dev-python/geotiler-0.20.0
	>=dev-python/gpxpy-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/fitdecode-0.10.0[${PYTHON_USEDEP}]
	dev-python/geographiclib[${PYTHON_USEDEP}]
	>=dev-python/progressbar2-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	>=dev-python/sqlitedict-2.1.0[${PYTHON_USEDEP}]
"
#	python_utils
#	languge: libraqm
#	media-fonts/roboto
#	dev-python/pycairo

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

# collecting ... collected 175 items / 3 errors
#distutils_enable_tests pytest

RESTRICT="test"
