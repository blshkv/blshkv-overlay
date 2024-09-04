# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="A WMI driver for Lenovo Legion series of laptops"
HOMEPAGE="https://github.com/adnanpri/legion-wmi"
HASH_COMMIT="fca8b563807776d0af1759cef808004feb4d7045"
SRC_URI="https://github.com/adnanpri/legion-wmi/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

CONFIG_CHECK="ACPI_WMI"
ERROR_NET="Lenovo WMI requires CONFIG_ACPI_WMI=y set in the kernel."

src_compile() {
	local modlist=( legion-wmi=drivers/platform/x86 )
	local modargs=( KVER="${KV_FULL}" KDIR="${KERNEL_DIR}" )
	linux-mod-r1_src_compile
}
