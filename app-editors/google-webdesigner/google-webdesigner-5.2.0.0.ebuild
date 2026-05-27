# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib rpm

MY_PV="${PV}-1"
# We are using the Red Hat/CentOS binary

DESCRIPTION="Google Web Designer"
HOMEPAGE="https://www.google.com/webdesigner/"
#https://support.google.com/webdesigner/answer/6000285
#https://dl.google.com/linux/webdesigner/rpm/stable/x86_64/repodata/repomd.xml
SRC_URI="
	amd64? ( https://dl.google.com/linux/webdesigner/rpm/stable/x86_64/google-webdesigner-${MY_PV}.x86_64.rpm )
	"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

QA_PREBUILT="opt/google/webdesigner/.*"

src_unpack() {
	#create a proper $S directory
	mkdir -p "${S}"
	cd "${S}"
	rpm_unpack
}

src_install() {
	doins -r opt
	doins -r usr
	fperms +x /opt/google/webdesigner/webdesigner
	dosym $(get_libdir)/libudev.so.1 $(get_libdir)/libudev.so.0
}
