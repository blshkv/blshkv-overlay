# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python client library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64"
IUSE="aiohttp bedrock datalib realtime vertex"

RDEPEND="
	>=dev-python/httpx2-2.12.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.13[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.10.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.16.0[${PYTHON_USEDEP}]

	aiohttp? (
		>=dev-python/aiohttp-3.14.4[${PYTHON_USEDEP}]
		>=dev-python/multidict-6.9.1[${PYTHON_USEDEP}]
		>=dev-python/yarl-1.25.1[${PYTHON_USEDEP}]
	)
	bedrock? (
		>=dev-python/botocore-1.40.0[${PYTHON_USEDEP}]
		>=dev-python/urllib3-2.7.0[${PYTHON_USEDEP}]
	)
	datalib? (
		dev-python/numpy[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.2.3[${PYTHON_USEDEP}]
	)
	realtime? ( >=dev-python/websockets-13[${PYTHON_USEDEP}] )
	vertex? ( >=dev-python/google-auth-2.36[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
