# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="rehlds/Metamod-R"
GITHUB_TAG="${PV}"
inherit github-archive cmake

DESCRIPTION="Improved plugin management and compatibility on modern HLDS-based servers"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

src_prepare() {
	eapply "${FILESDIR}/${P}-ldflags.patch"
	cmake_src_prepare
}

src_install() {
	insinto /opt/Steam/metamod/
	doins "${BUILD_DIR}"/metamod/metamod_i386.so
}
