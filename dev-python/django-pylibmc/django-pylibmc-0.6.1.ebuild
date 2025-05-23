# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
inherit distutils-r1

DESCRIPTION="Django cache backend using pylibmc"
HOMEPAGE="https://pypi.org/project/django-pylibmc/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="dev-python/pylibmc[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
