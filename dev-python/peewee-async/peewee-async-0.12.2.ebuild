# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous interface for peewee ORM powered by asyncio."
HOMEPAGE="https://github.com/05bit/peewee-async"
#SRC_URI="https://github.com/05bit/peewee-async/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mysql postgres"

RDEPEND=">=dev-python/peewee-3.15.5[${PYTHON_USEDEP}]
	>=dev-python/importlib-metadata-6.7.0[${PYTHON_USEDEP}]
	mysql? ( dev-python/aiomysql[${PYTHON_USEDEP}] )
	postgres? ( dev-python/aiopg[${PYTHON_USEDEP}] )
"
#FIXME:
#	mysql dev-python/aiomysql
#	mysql = ["aiomysql", "cryptography"]

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_install() {
	distutils-r1_python_install

	# install include files
	# https://github.com/05bit/peewee-async/issues/317
	python_domodule peewee_asyncext.py
	# $(python_get_sitedir)/${PN}/
	python_domodule peewee_async_compat.py
}

pkg_postinst() {
	ewarn "This is a migration version, see:"
	ewarn "https://github.com/05bit/peewee-async/issues/316"
}
