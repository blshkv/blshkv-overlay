# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{13..14} )
inherit python-r1 git-r3

DESCRIPTION="Video stabilization using Progressively Optimized Local Radiance Fields"
HOMEPAGE="https://github.com/facebookresearch/localrf https://localrf.github.io/"
EGIT_REPO_URI="https://github.com/facebookresearch/localrf.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]
	media-libs/opencv
	dev-python/ConfigArgParse[${PYTHON_USEDEP}]

	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]

	sci-visualization/tensorboard
	dev-python/imageio[${PYTHON_USEDEP}]

	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]

	dev-python/joblib[${PYTHON_USEDEP}]

"
# lpips
# kornia
# easydict
# plyfile
# timm

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
