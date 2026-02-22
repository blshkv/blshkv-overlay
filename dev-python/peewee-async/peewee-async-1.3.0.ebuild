# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous interface for peewee ORM powered by asyncio."
HOMEPAGE="https://github.com/05bit/peewee-async"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mysql postgres psycopg"

RDEPEND=">=dev-python/peewee-3.15.5[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=dev-python/importlib-metadata-6.7.0[${PYTHON_USEDEP}]
	mysql? ( dev-python/aiomysql[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}] )
	postgres? ( dev-python/aiopg[${PYTHON_USEDEP}] )
	psycopg? ( dev-python/psycopg:0[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
