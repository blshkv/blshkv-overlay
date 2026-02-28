# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2

MY_P="LanguageTool-${PV}"

DESCRIPTION="Local server for LanguageTool"
HOMEPAGE="https://dev.languagetool.org/http-server.html"
SRC_URI="https://languagetool.org/download/LanguageTool-${PV}.zip"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="dev-libs/fastText
	>=virtual/jre-25:*"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

src_install() {
	dodir /usr/share/${PN}
	# Using doins -r would strip executable bits from all binaries
	cp -pPR ./* "${D}"/usr/share/${PN} || die "Failed to copy files"

	insinto /usr/share/${PN}
	doins "${FILESDIR}"/server.properties

	newbin - languagetool-server <<-EOF
#!/bin/sh

cd /usr/share/languagetool
java -Xmx512M -cp languagetool-server.jar org.languagetool.server.HTTPServer --config server.properties --port 8081 --allow-origin
EOF

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
