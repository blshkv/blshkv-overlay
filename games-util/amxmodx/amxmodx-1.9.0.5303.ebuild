# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/alliedmodders/amxmodx"
EGIT_COMMIT="${PV}"
EGIT_SUBMODULES=( 'public/amtl' )

DESCRIPTION="AMX Mod X - Half-Life 1 server-side Metamod plugin for game administration"
HOMEPAGE="https://www.amxmodx.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug mysql +cstrike dod esf ns tfc ts"

# 32-bit .so files compiled without -fPIC
QA_TEXTRELS="
	opt/Steam/${PN}/addons/amxmodx/dlls/*
	opt/Steam/${PN}/addons/amxmodx/modules/*
	opt/Steam/${PN}/cstrike/addons/amxmodx/modules/*
	opt/Steam/${PN}/dod/addons/amxmodx/modules/*
	opt/Steam/${PN}/esf/addons/amxmodx/modules/*
	opt/Steam/${PN}/ns/addons/amxmodx/modules/*
	opt/Steam/${PN}/tfc/addons/amxmodx/modules/*
	opt/Steam/${PN}/ts/addons/amxmodx/modules/*
	usr/bin/amxxpc32.so
"

#CONFIG_PROTECT="/opt/Steam/${PN}/addons/amxmodx/configs"

BDEPEND="
	dev-build/ambuild
	dev-lang/nasm
"

# TODO: add when ebuilds exist:
#   games-util/hlsdk
#   games-util/metamod-hl1
# mysql? ( dev-db/mysql:= )
#RDEPEND=""
#DEPEND=""

HLSDK_DIR="${WORKDIR}/hlsdk"
METAMOD_DIR="${WORKDIR}/metamod-hl1"
BUILD_DIR="${S}/build"

src_unpack() {
	# Main source + public/amtl submodule
	git-r3_src_unpack

	# Half-Life SDK headers required by configure.py
	git-r3_fetch "https://github.com/alliedmodders/hlsdk" HEAD
	git-r3_checkout "https://github.com/alliedmodders/hlsdk" "${HLSDK_DIR}"

	# Metamod source headers required by configure.py
	git-r3_fetch "https://github.com/alliedmodders/metamod-hl1" HEAD
	git-r3_checkout "https://github.com/alliedmodders/metamod-hl1" "${METAMOD_DIR}"
}

src_prepare() {
	eapply "${FILESDIR}/${P}-amtl-cxx20-ctor.patch"
	eapply "${FILESDIR}/${P}-regex-notext.patch"
	eapply "${FILESDIR}/${P}-prefix-const.patch"
	eapply "${FILESDIR}/${P}-libpc300-notext.patch"
	eapply "${FILESDIR}/${P}-amxmodx-notext.patch"
	eapply "${FILESDIR}/${P}-sqlite-notext.patch"
	eapply_user
}

src_configure() {
	mkdir -p "${BUILD_DIR}" || die
	cd "${BUILD_DIR}" || die

	local myargs=(
		--enable-optimize
		--disable-auto-versioning
		--hlsdk="${HLSDK_DIR}"
		--metamod="${METAMOD_DIR}"
	)
	use debug && myargs+=( --enable-debug )
	use mysql || myargs+=( --no-mysql )

	python "${S}/configure.py" "${myargs[@]}" || die
}

src_compile() {
	ambuild "${BUILD_DIR}" || die
}

src_install() {
	# Base package: game-agnostic dlls, modules, plugins, configs, scripting, data
	insinto /opt/Steam
	doins -r "${BUILD_DIR}/packages/base/."

	# Game-specific packages (extra modules, plugins, configs)
	local game
	for game in cstrike dod esf ns tfc ts; do
		use ${game} || continue
		[[ -d "${BUILD_DIR}/packages/${game}" ]] || continue
		insinto /opt/Steam/${PN}/${game}
		doins -r "${BUILD_DIR}/packages/${game}/."
	done

	# Pawn compiler; amxxpc32.so must live alongside amxxpc (binreloc finds it there)
	dobin "${BUILD_DIR}/compiler/amxxpc/amxxpc/amxxpc"
	dobin "${BUILD_DIR}/compiler/libpc300/amxxpc32/amxxpc32.so"

	# doins installs 0644; shared libraries need to be executable
	find "${ED}/opt/Steam" -name "*.so" -exec chmod 0755 {} +
}
