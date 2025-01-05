# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//-bin/}"
inherit java-pkg-2

DESCRIPTION=""
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://github.com/peregin/gps-overlay-on-video/releases/download/v${PV}/gps-overlay-on-video.jar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( virtual/jre virtual/jdk )
	|| ( dev-java/sbt-bin dev-java/sbt )"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/gps-overlay-on-video.jar" || die
}

src_install() {
	insinto "/opt/gps-overlay-on-video/"
	doins gps-overlay-on-video.jar
	cp ${FILESDIR}/gps-overlay-on-video "${ED}"/opt/gps-overlay-on-video/
	dosym "${EPREFIX}"/opt/gps-overlay-on-video/gps-overlay-on-video /usr/bin/gps-overlay-on-video
}

#src_install() {
#	java-pkg_jarinto /opt/"${MY_PN}"
#	java-pkg_newjar "${MY_PN}.jar"
#	java-pkg_dolauncher "${MY_PN}" --jar "${PN}.jar" --java_args "-Xmx2G --add-opens=java.desktop/javax.swing.plaf.basic=ALL-UNNAMED"
#}
