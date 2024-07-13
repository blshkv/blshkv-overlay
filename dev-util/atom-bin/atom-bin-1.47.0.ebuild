# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://atom-installer.github.com/v1.47.0/atom.x86_64.rpm?s=1589835159&ext=.rpm -> ${P}-x86_64.rpm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

QA_PREBUILT=/usr/share/atom/*

src_install() {
#	insinto /
#	doins -r *
	# Using doins -r would strip executable bits from all binaries
	cp -pPR * "${ED}"/ || die "Failed to copy files"
}
