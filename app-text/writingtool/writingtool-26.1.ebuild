# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="WritingTool-${PV}"
OFFICE_REQ_USE="java"
OFFICE_EXTENSIONS=( "${MY_P}.oxt" )
inherit office-ext-r1

DESCRIPTION="Style and Grammar Checker for LibreOffice fork of languagetool"
HOMEPAGE="https://writingtool.org"
SRC_URI="https://github.com/writingtool-org/writingtool/releases/download/v${PV}/${MY_P}.oxt"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-17"
