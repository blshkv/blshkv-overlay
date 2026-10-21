# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="https://github.com/jlowin/fastmcp https://pypi.org/project/fastmcp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.9.4[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.15.2[${PYTHON_USEDEP}]
	>=dev-python/authlib-1.5.2[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/uv-dynamic-versioning[${PYTHON_USEDEP}]"

python_compile() {
	local -x UV_DYNAMIC_VERSIONING_BYPASS=${PV}
	distutils-r1_python_compile
}
