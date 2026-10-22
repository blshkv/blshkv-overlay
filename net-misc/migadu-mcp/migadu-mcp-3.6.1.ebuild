# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 pypi

DESCRIPTION="MCP server for Migadu email hosting"
HOMEPAGE="https://github.com/Michaelzag/migadu-mcp https://pypi.org/project/migadu-mcp/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/fastmcp-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/email-validator-2.0.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

python_compile() {
	local -x SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
	distutils-r1_python_compile
}
