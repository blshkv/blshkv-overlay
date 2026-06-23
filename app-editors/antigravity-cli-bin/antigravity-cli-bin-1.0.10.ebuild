# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Google Antigravity CLI (binary release)"
HOMEPAGE="https://antigravity.google/"

# extracted from install.sh:
#  amd64:
#    https://antigravity-cli-auto-updater-974169037036.us-central1.run.app/manifests/linux_amd64.json
#  arm64:
#   https://antigravity-cli-auto-updater-974169037036.us-central1.run.app/manifests/linux_arm64.json
RANDOM_SHIT="6349723456634880"
GOOGLE_URL="storage.googleapis.com/antigravity-public/antigravity-cli"

SRC_URI="amd64? ( https://${GOOGLE_URL}/${PV}-${RANDOM_SHIT}/linux-x64/cli_linux_x64.tar.gz  -> ${P}-amd64.tar.gz )
	arm64? ( https://${GOOGLE_URL}/${PV}-${RANDOM_SHIT}/linux-arm/cli_linux_arm64.tar.gz  -> ${P}-arm64.tar.gz )
"

LICENSE="Antigravity"
SLOT="0"
KEYWORDS="amd64 ~arm64"
RESTRICT="bindist mirror strip"

S="${WORKDIR}"

#QA_PREBUILT="*"

src_install() {
	newbin antigravity antigravity-cli
}
