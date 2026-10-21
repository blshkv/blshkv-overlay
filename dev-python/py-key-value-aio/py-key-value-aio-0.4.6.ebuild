# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Async key-value store interface with multiple backend support"
HOMEPAGE="https://github.com/akettmann/py-key-value-aio https://pypi.org/project/py-key-value-aio/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="filetree"

RDEPEND="
	>=dev-python/beartype-0.20.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.6.0[${PYTHON_USEDEP}]
	filetree? (
		>=dev-python/aiofile-3.12.3[${PYTHON_USEDEP}]
		>=dev-python/anyio-4.4.0[${PYTHON_USEDEP}]
	)
"
