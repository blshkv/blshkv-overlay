# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

# no pyton 3.12: sci-geosciences/GeographicLib
PYTHON_COMPAT=( python3_{10..12} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="GoPro MP4 & Generic GPX/FIT files and create video dashboards & maps"
HOMEPAGE="https://github.com/time4tea/gopro-dashboard-overlay"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-python/pillow-10.1.0[raqm,${PYTHON_USEDEP}]
	>=dev-python/pint-0.22[${PYTHON_USEDEP}]
	>=dev-python/geotiler-0.15[${PYTHON_USEDEP}]
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

#distutils_enable_tests pytest
