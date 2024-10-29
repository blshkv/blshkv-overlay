# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Wrapper package for OpenCV python bindings."
HOMEPAGE="https://github.com/skvark/opencv-python https://pypi.org/project/opencv-python-headless/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/scikit-build[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

src_prepare() {
	#https://pypi.org/project/opencv-python/
	einfo "DEBUG!!!!!!!"
	export CMAKE_ARGS='-DCMAKE_VERBOSE_MAKEFILE=ON'
	export VERBOSE=1
	export ENABLE_HEADLESS=1
	#Build with Qt Backend support
	export WITH_QT=5
	echo 1 > headless.enabled

	eapply_user

}

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
