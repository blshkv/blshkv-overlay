# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Recognize faces from Python or from the command line"
HOMEPAGE="https://github.com/ageitgey/face_recognition https://pypi.org/project/face_recognition/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

#nosetests: command not found
RESTRICT="test"

RDEPEND=">=dev-python/face_recognition_models-0.3.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/click-6.0[${PYTHON_USEDEP}]
	>=sci-libs/dlib-19.7[python,${PYTHON_USEDEP}]"
#DEPEND="${RDEPEND}
#	test? (
#		dev-python/nose[${PYTHON_USEDEP}]
#		dev-python/pytest[${PYTHON_USEDEP}]
#	)"

#python_test() {
#	nosetests --verbose || die
#	py.test -v -v || die
#}
