# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit python-r1 git-r3

DESCRIPTION="Avatars for Zoom, Skype and other video-conferencing apps"
HOMEPAGE="https://github.com/alievk/avatarify-python"
EGIT_REPO_URI="https://github.com/alievk/avatarify-python.git"

LICENSE="CC-BY-NC-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-video/v4l2loopback
	media-libs/opencv[gstreamer,v4l,${PYTHON_USEDEP}]
	|| ( dev-python/opencv-python[${PYTHON_USEDEP}] dev-python/opencv-python-bin[${PYTHON_USEDEP}] )
	=dev-python/face-alignment-1.3*[${PYTHON_USEDEP}]
	>=dev-python/pyzmq-25.0.1[${PYTHON_USEDEP}]
	>=dev-python/msgpack-numpy-0.4.7.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	dev-python/pyfakewebcam[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
