# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="OpenAPI (v3) data model for Python using Pydantic"
HOMEPAGE="https://github.com/mike-oakley/openapi-pydantic https://pypi.org/project/openapi-pydantic/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-python/pydantic-1.8[${PYTHON_USEDEP}]"
