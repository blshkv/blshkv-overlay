# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="2D and 3D Face alignment library build using pytorch"
HOMEPAGE="https://github.com/1adrianb/face-alignment"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

#FIXME
RESTRICT="test"

RDEPEND="
	media-libs/opencv[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.17.0[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
