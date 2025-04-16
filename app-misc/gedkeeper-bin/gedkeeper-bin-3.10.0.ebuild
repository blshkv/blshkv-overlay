# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

MY_P="${PN//-bin/}_${PV}-1_all.deb"
#MY_P="${MY_PN}-${PV/_rc/-rc-}"

DESCRIPTION="Personal genealogical database"
HOMEPAGE="https://gedkeeper.github.io/"
SRC_URI="https://github.com/Serg-Norseman/GEDKeeper/releases/download/v${PV}/${MY_P}"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

#RESTRICT="mirror fetch strip"

#QA_PREBUILT="opt/nessus/bin/nasl"

RDEPEND="dev-lang/mono
	dev-dotnet/libgdiplus
	dev-db/sqlite"
DEPEND="${RDEPEND}"

#src_unpack() {
#	unpacker "${MY_P}"
#}

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}/usr" "${D}"/ || die "Failed to copy files"
}
