# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

MY_PV=$(ver_rs '_')

DESCRIPTION="Open-source graph component for Java"
SRC_URI="https://github.com/jgraph/jgraphx/archive/v${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="http://www.jgraph.com"
IUSE="doc examples source"
DEPEND="virtual/jdk:11
	app-arch/unzip"
RDEPEND=">=virtual/jre-11"
LICENSE="BSD"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 x86"

src_prepare() {
	# don't do javadoc always
	sed -i \
		-e 's/depends="doc"/depends="compile"/' \
		build.xml || die "sed failed"
	rm -rf doc/api lib/jgraphx.jar || die
	eapply_user
}

EANT_BUILD_TARGET="build"
EANT_DOC_TARGET="doc"

src_install() {
	java-pkg_dojar lib/${PN}.jar

	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/org
	use examples && java-pkg_doexamples examples
}
