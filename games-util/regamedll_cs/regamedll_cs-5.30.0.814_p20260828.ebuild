# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="rehlds/ReGameDLL_CS"
GITHUB_COMMIT="b0889847fe6d03898be88acc9e366660efb40ab5"
inherit github-archive cmake flag-o-matic

DESCRIPTION="Enhanced version of the CS game DLL for HLDS"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# Intentionally non-PIC i386 shared library
QA_TEXTRELS="opt/Steam/regamedll/cstrike/dlls/cs.so"

src_install() {
	insinto /opt/Steam/regamedll/cstrike/dlls
	doins "${BUILD_DIR}"/regamedll/cs.so
}
