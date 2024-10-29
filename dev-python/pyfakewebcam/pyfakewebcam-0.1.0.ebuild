# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="An API for writing RGB frames to a fake webcam device on Linux!"
HOMEPAGE="https://github.com/jremmons/pyfakewebcam"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

