# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Check if phone numbers are connected to Telegram accounts"
HOMEPAGE="https://github.com/bellingcat/telegram-phone-number-checker/tree/main"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/anyio-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/idna-3.6[${PYTHON_USEDEP}]
	>=dev-python/pyaes-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/rsa-4.9[${PYTHON_USEDEP}]
	>=dev-python/sniffio-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/Telethon-1.33.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9.0[${PYTHON_USEDEP}]

"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
