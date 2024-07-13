# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator vmware-bundle

# VMware-ClientIntegrationPlugin-6.2.0.x86_64.bundle
MY_PN="VMware-ClientIntegrationPlugin"
MY_P="${MY_PN}-${PV}"

#https://aur.archlinux.org/packages/vmware-vsphere-web-client-plugin/
#http://www.win.tue.nl/~vincenth/vmware-cip.html

DESCRIPTION="Firefox and Chromium plugin, to access virtual machines console from vSphere Web Client"
HOMEPAGE="https://docs.vmware.com/en/VMware-Skyline-Collector/services/Planning-and-Deployment-Guide/GUID-E0C9F316-6B63-4547-8119-875C80FA2DAE.html"
SRC_URI="
	amd64? ( http://vsphereclient.vmware.com/vsphereclient/4/2/7/4/6/6/6/${MY_P}.x86_64.bundle )
	"
#	x86? ( ${MY_P}.i386.bundle )

LICENSE="vmware"
SLOT="0"
#FIXME: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=vmware-vsphere-web-client-plugin
#KEYWORDS="~amd64"
IUSE="doc"
RESTRICT="strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND=""
#	dev-libs/glib:2
#	dev-libs/libxml2
#	=dev-libs/openssl-0.9.8*
#	net-misc/curl
#	sys-libs/glibc
#	sys-libs/zlib
#	!app-emulation/vmware-workstation"

S=${WORKDIR}
VM_INSTALL_DIR="/opt/vmware"

pkg_nofetch() {
	local bundle

	if use x86; then
		bundle="${MY_P}.i386.bundle"
	elif use amd64; then
		bundle="${MY_P}.x86_64.bundle"
	fi

	einfo "Please download ${bundle}"
	einfo "from ${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
#	default
	local component; for component in \
		vmware-cip-60 \
		vmware-installer \
		vmware-usbarbitrator \
		vmware-vmrc-5.5
	do
		vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" "${component}" "${S}"
#		vmware-bundle_extract-component "${DISTDIR}/${A}" "${component}" "${S}"
	done
}

src_install() {
	# install the binary
#	into "${VM_INSTALL_DIR}"
#	dobin bin/*

	# install the libraries
	insinto "${VM_INSTALL_DIR}"/lib/vmware-vix
	doins -r lib/*

#	dosym vmware-vix/libvixAllProducts.so "${VM_INSTALL_DIR}"/lib/libbvixAllProducts.so

	# install headers
#	insinto /usr/include/vmware-vix
#	doins include/*

#	if use doc; then
#		dohtml -r doc/*
#	fi

	# fix permissions
#	fperms 0755 "${VM_INSTALL_DIR}"/lib/vmware-vix/setup/vmware-config

	# create the environment
	local envd="${T}/90${PN}"
	cat > "${envd}" <<-EOF
		PATH='${VM_INSTALL_DIR}/bin'
		ROOTPATH='${VM_INSTALL_DIR}/bin'
	EOF
	doenvd "${envd}"

	# create the configuration
	dodir /etc/vmware

	local vmconfig="${T}/config"
	if [[ -e ${ROOT}/etc/vmware/config ]]
	then
		cp -a "${ROOT}"/etc/vmware/config "${vmconfig}"
		sed -i -e "/vmware.fullpath/d" "${vmconfig}"
		sed -i -e "/vix.libdir/d" "${vmconfig}"
		sed -i -e "/vix.config.version/d" "${vmconfig}"
	fi

	cat >> "${vmconfig}" <<-EOF
		vmware.fullpath = "${VM_INSTALL_DIR}/bin/vmware"
		vix.libdir = "${VM_INSTALL_DIR}/lib/vmware-vix"
		vix.config.version = "1"
	EOF

	insinto /etc/vmware/
	doins "${vmconfig}"
}

pkg_postinst() {
	ewarn "/etc/env.d was updated. Please run:"
	ewarn "env-update && source /etc/profile"
}

pkg_prerm() {
	sed -i -e "/vix.libdir/d" "${ROOT}"/etc/vmware/config
}
