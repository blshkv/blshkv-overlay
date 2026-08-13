# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="rehlds/ReGameDLL_CS"
GITHUB_TAG="${PV}"
inherit github-archive cmake flag-o-matic

DESCRIPTION="Enhanced version of the CS game DLL for HLDS"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# Intentionally non-PIC i386 shared library
QA_TEXTRELS="opt/Steam/regamedll/cstrike/dlls/cs.so"

src_prepare() {
	eapply "${FILESDIR}/${P}-ldflags.patch"
	eapply "${FILESDIR}/${P}-notext.patch"
	cmake_src_prepare
}

src_configure() {
	# i386 shared lib built without -fPIC; LTO produces text relocations
	# that modern ld rejects as an error.
	filter-lto
	cmake_src_configure
}

src_install() {
	insinto /opt/Steam/regamedll/cstrike/dlls
	doins "${BUILD_DIR}"/regamedll/cs.so
}
