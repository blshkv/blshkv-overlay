# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="VMware-vix-disklib-${PV}-21562716"

DESCRIPTION="VMware vSphere Virtual Disk Development Kit (VDDK)"
HOMEPAGE="https://code.vmware.com/web/sdk/$(ver_cut 1-2)/vddk"
SRC_URI="
	amd64? ( ${MY_P}.x86_64.tar.gz )
	"
LICENSE="vmware GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND=""
PDEPEND=""

S=${WORKDIR}/${PN}-distrib

VM_INSTALL_DIR="/opt/vmware"
VM_LIB_DIR="/usr/lib/vmware/"

src_install() {
	# install the binaries
	into "${VM_INSTALL_DIR}"
	dobin bin64/*

	# install the libraries
	insinto "${VM_LIB_DIR}"
	doins -r lib64/*

	doenvd "${FILESDIR}/81${PN}"
}
