# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker
MY_P="${P//-bin/}-1-x86_64.pkg.tar.zst"

DESCRIPTION="Personal genealogical database"
HOMEPAGE="https://gedkeeper.github.io/"
SRC_URI="https://github.com/Serg-Norseman/GEDKeeper/releases/download/v${PV}/${MY_P}"
#         https://github.com/Serg-Norseman/GEDKeeper/releases/download/v3.3.0/gedkeeper-3.3.0-1-x86_64.pkg.tar.zst

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

#RESTRICT="mirror fetch strip"

#QA_PREBUILT="opt/nessus/bin/nasl"

RDEPEND="dev-lang/mono
	dev-dotnet/libgdiplus
	dev-db/sqlite"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpacker "${MY_P}"
}

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}/usr" "${D}"/ || die "Failed to copy files"
}
