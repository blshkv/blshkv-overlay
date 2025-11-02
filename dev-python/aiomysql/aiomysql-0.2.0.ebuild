# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Library for accessing a MySQL database from the asyncio"
HOMEPAGE="
	https://pypi.python.org/pypi/aiomysql
	https://github.com/aio-libs/aiomysql
	https://aiomysql.readthedocs.io/en/latest/
"
SRC_URI="https://github.com/aio-libs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="sqlalchemy"

RDEPEND="dev-python/pymysql[${PYTHON_USEDEP}]
	sqlalchemy? ( dev-python/sqlalchemy[${PYTHON_USEDEP}] )
"
#        PyMySQL[rsa]

BDEPEND="
	test? (
		$(python_gen_impl_dep "ssl")
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

DOCS=( CHANGES.txt {CONTRIBUTING,README}.rst )

EPYTEST_IGNORE=(
	# No Table.count() method in recent PyMySQL
	tests/test_async_with.py
	tests/sa/test_sa_connection.py
	tests/sa/test_sa_transaction.py
)

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx

python_test() {
	epytest "${S}"/tests --mysql-unix-socket "$(emysql --get-sockfile)"
}

src_test() {
	emysql --start 3333
	local sockfile=$(emysql --get-sockfile)
	local -x MYSQL_ROOT_PASSWORD="rootpw"

	ebegin "Changing database password"
	mysql --user=root --socket="${sockfile}" --silent \
		--execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	eend $? || emysql --die "Changing database password failed"

	distutils-r1_src_test

	emysql --stop
}
