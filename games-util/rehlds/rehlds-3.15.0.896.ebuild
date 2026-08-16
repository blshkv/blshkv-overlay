# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="rehlds/ReHLDS"
GITHUB_TAG="${PV}"
inherit github-archive cmake flag-o-matic

DESCRIPTION="Enhanced version of the HLDS engine"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="debug"

# Intentionally non-PIC i386 shared libraries
QA_TEXTRELS="
	opt/Steam/rehlds/engine_i486.so
	opt/Steam/rehlds/filesystem_stdio.so
	opt/Steam/rehlds/core.so
	opt/Steam/rehlds/proxy.so
	opt/Steam/rehlds/demoplayer.so
	opt/Steam/rehlds/valve/dlls/director.so
"

# Legacy game server executables require executable stack
QA_EXECSTACK="
	opt/Steam/rehlds/hlds_linux
	opt/Steam/rehlds/hltv
"

src_prepare() {
	eapply "${FILESDIR}/${P}-notext.patch"
	eapply "${FILESDIR}/${P}-no-hardcoded-lto.patch"
	eapply "${FILESDIR}/${P}-sigaction-init.patch"
	cmake_src_prepare
}

src_configure() {
	# i386 shared libs are intentionally built without -fPIC; LTO causes the
	# linker to generate text relocations which modern ld rejects as an error.
	filter-lto
	local mycmakeargs=(
		-DDEBUG=$(usex debug ON OFF)
	)
	cmake_src_configure
}

src_install() {
	insinto /opt/Steam/rehlds/
	doins "${BUILD_DIR}"/rehlds/engine_i486.so
	doins "${BUILD_DIR}"/rehlds/HLTV/Core/core.so
	doins "${BUILD_DIR}"/rehlds/HLTV/DemoPlayer/demoplayer.so
	doins "${BUILD_DIR}"/rehlds/HLTV/Proxy/proxy.so
	doins "${BUILD_DIR}"/rehlds/filesystem/FileSystem_Stdio/filesystem_stdio.so

	exeinto /opt/Steam/rehlds/
	doexe "${BUILD_DIR}"/rehlds/dedicated/hlds_linux
	doexe "${BUILD_DIR}"/rehlds/HLTV/Console/hltv

	insinto /opt/Steam/rehlds/valve/dlls
	doins "${BUILD_DIR}"/rehlds/HLTV/Director/director.so
	
	#the following libraries need to be removed from steam installation:
	#or create a symlink, perhaps?
	#libgcc_s.so.1
	#libstdc++.so.6
}
