# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="WiFi network evaluator that recommends the optimal saved network"
HOMEPAGE="https://github.com/sourabh-khot65/roamr"
SRC_URI="
	https://github.com/sourabh-khot65/roamr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/blshkv/gentoo-golang-dist/releases/download/${PN}-${PV}/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"

RDEPEND="net-misc/networkmanager"

src_compile() {
	ego build -ldflags "-s -w -X main.version=${PV}" ./cmd/roamr
}

src_install() {
	dobin roamr
}
