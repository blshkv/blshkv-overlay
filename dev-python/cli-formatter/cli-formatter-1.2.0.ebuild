# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Utility for CLI scripts to prettify their output"
HOMEPAGE="https://github.com/wahlflo/cli-formatter https://pypi.org/project/cli-formatter/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
