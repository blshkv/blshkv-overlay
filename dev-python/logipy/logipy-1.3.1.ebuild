# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A simple python wrapper for Logitech G's LED and Arx SDKs."
HOMEPAGE="https://pypi.org/project/logipy https://github.com/Logitech/logiPy"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}" ".zip")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

#EPATCH_OPTS="--ignore-whitespace -p10"
#PATCHES=( "${FILESDIR}/python3.patch" )

src_prepare(){
	eapply --binary ${FILESDIR}/python3.patch
	eapply_user
}
