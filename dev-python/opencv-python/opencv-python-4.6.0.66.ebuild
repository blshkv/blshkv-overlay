# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="Wrapper package for OpenCV python bindings."
HOMEPAGE="https://github.com/skvark/opencv-python https://pypi.org/project/opencv-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="
	media-libs/opencv[-python]
	dev-python/scikit-build[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

PATCHES=(
	"${FILESDIR}"/${PN}-3.4.0-disable-download.patch
	"${FILESDIR}"/${PN}-3.4.1-cuda-add-relaxed-constexpr.patch
	"${FILESDIR}"/${PN}-4.1.2-opencl-license.patch
	"${FILESDIR}"/${PN}-4.4.0-disable-native-cpuflag-detect.patch
	"${FILESDIR}"/${PN}-4.5.0-link-with-cblas-for-lapack.patch
	"${FILESDIR}"/${PN}-4.6.0-fix-build-examples.patch # bug 830163, pending upstream PR #22245
)

src_prepare() {

	# https://bugs.gentoo.org/838274
#	replace-flags -O3 -O2

#	export CMAKE_ARGS='-DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_SHARED_LIBS=ON -DWITH_QT=5'
	export CMAKE_ARGS='-DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_SHARED_LIBS=OFF -DWITH_QT=5'
#	export BUILD_SHARED_LIBS=OFF
#	export VERBOSE=1
#	export WITH_QT=5

	eapply_user

}

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
