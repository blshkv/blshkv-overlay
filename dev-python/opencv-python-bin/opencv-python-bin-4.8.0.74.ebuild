# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_EXT=1
#DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_PEP517=scikit-build-core

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{12..13} )
inherit python-r1 python-utils-r1

DESCRIPTION="Wrapper package for OpenCV python bindings."
HOMEPAGE="https://github.com/skvark/opencv-python https://pypi.org/project/opencv-python"
SRC_URI="https://files.pythonhosted.org/packages/34/7c/8a5043f362b0a55f07812a0db3f86092cdbd0fe41b933d7bc6fce3ab6c15/opencv_python-4.8.0.74-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE=""
#RESTRICT="!test? ( test )"

DOCS="README.md"

#RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
#BDEPEND="
#	dev-python/scikit-build[${PYTHON_USEDEP}]
#	dev-python/setuptools[${PYTHON_USEDEP}]
#	test? (
#		dev-python/pytest[${PYTHON_USEDEP}]
#	)"

S="${WORKDIR}/"

pkg_setup() {
	python_setup
}

src_install(){
	insinto "$(python_get_sitedir)"
	doins -r *

#	if use amd64; then
#		doins orjson.cpython-310-x86_64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-39-x86_64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-38-x86_64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-x86_64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-37-x86_64-linux-gnu.so
#	elif use arm64; then
#		doins orjson.cpython-310-aarch64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-39-aarch64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-38-aarch64-linux-gnu.so
#		dosym  $(python_get_sitedir)/orjson.cpython-310-aarch64-linux-gnu.so $(python_get_sitedir)/orjson.cpython-37-aarch64-linux-gnu.so
#	fi

}
