# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=6.0

NUGETS="
system.io.compression@4.3.0
system.memory@4.5.0
system.memory@4.5.3
system.memory@4.5.5
system.net.nameresolution@4.3.0
microsoft.net.test.sdk@17.6.2
itextsharp.lgplv2.core@3.3.3
runtime.native.system.security.cryptography.apple@4.3.0
runtime.native.system.security.cryptography.apple@4.3.1
system.globalization.calendars@4.3.0
system.security.accesscontrol@4.5.0
system.security.accesscontrol@6.0.0
system.security.accesscontrol@4.7.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.algorithms@4.3.1
system.codedom@4.7.0
atksharp@3.24.24.38
runtime.unix.system.private.uri@4.3.0
runtime.win-x64.runtime.native.system.data.sqlclient.sni@4.4.0
system.security.claims@4.3.0
runtime.native.system.data.sqlclient.sni@4.7.0
runtime.any.system.reflection@4.3.0
eto.platform.gtk@2.8.0
sqlitepclraw.core@2.0.4
system.configuration.configurationmanager@4.5.0
system.configuration.configurationmanager@6.0.0
system.configuration.configurationmanager@4.7.0
runtime.native.system@4.3.0
system.runtime.handles@4.3.0
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.0
nlua@1.6.2
system.diagnostics.eventlog@6.0.0
system.text.encoding.codepages@7.0.0
system.text.encoding.codepages@4.7.0
system.text.encoding.codepages@5.0.0
system.threading.threadpool@4.3.0
entityframework@6.4.4
system.security.cryptography.primitives@4.3.0
lucene.net@4.8.0-beta00016
microsoft.win32.registry@4.7.0
runtime.native.system.io.compression@4.3.0
oxyplot.core@2.1.0
cairosharp@3.24.24.38
newtonsoft.json@13.0.1
system.resources.resourcemanager@4.3.0
system.security.cryptography.openssl@4.3.0
system.text.regularexpressions@4.3.0
sqlite-net-pcl@1.8.116
oxyplot.eto@1.1.0
runtime.any.system.reflection.primitives@4.3.0
stub.system.data.sqlite.core.netstandard@1.0.117
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
system.text.encoding.extensions@4.3.0
system.globalization.extensions@4.3.0
system.componentmodel.annotations@4.7.0
system.componentmodel.annotations@5.0.0
runtime.any.system.reflection.extensions@4.3.0
eto.forms@2.8.0
system.console@4.3.0
system.net.sockets@4.3.0
lucene.net.sandbox@4.8.0-beta00016
nunit3testadapter@4.5.0
system.security.permissions@4.5.0
system.security.permissions@6.0.0
system.security.permissions@4.7.0
system.diagnostics.debug@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.0
system.linq.expressions@4.3.0
runtime.unix.system.diagnostics.debug@4.3.0
microsoft.win32.primitives@4.3.0
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.unix.system.runtime.extensions@4.3.0
lucene.net.queries@4.8.0-beta00016
microsoft.extensions.primitives@2.0.0
runtime.any.system.io@4.3.0
enums.net@4.0.1
eto.serialization.xaml@2.8.0
system.text.encoding@4.3.0
system.buffers@4.5.1
system.buffers@4.3.0
system.buffers@4.4.0
system.objectmodel@4.3.0
microsoft.extensions.configuration.abstractions@2.0.0
system.io.filesystem@4.3.0
system.reflection.emit.ilgeneration@4.3.0
system.formats.asn1@6.0.0
system.private.uri@4.3.0
yamldotnet@12.0.0
system.reflection@4.3.0
bouncycastle.cryptography@2.0.0
bouncycastle.cryptography@2.2.1
keralua@1.3.2
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.1
system.xml.readerwriter@4.3.0
system.xml.readerwriter@4.3.1
system.threading.tasks@4.3.0
system.security.principal@4.3.0
system.security.cryptography.cng@4.3.0
system.io.compression.zipfile@4.3.0
sqlitepclraw.provider.e_sqlite3@2.0.4
runtime.native.system.net.http@4.3.0
sqlitepclraw.bundle_green@2.0.4
system.drawing.common@6.0.0
system.drawing.common@4.7.0
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.0
sixlabors.imagesharp@2.1.4
sixlabors.imagesharp@3.0.1
system.runtime@4.3.0
microsoft.netframework.referenceassemblies@1.0.3
runtime.unix.system.net.sockets@4.3.0
runtime.any.system.runtime.interopservices@4.3.0
system.reflection.extensions@4.3.0
system.collections.nongeneric@4.3.0
system.data.sqlite@1.0.117
system.net.requests@4.3.0
microsoft.csharp@4.7.0
nsubstitute@5.0.0
runtime.any.system.collections@4.3.0
system.security.cryptography.xml@6.0.1
runtime.any.system.runtime.handles@4.3.0
runtime.any.system.runtime@4.3.0
runtime.win-x86.runtime.native.system.data.sqlclient.sni@4.4.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.numerics.vectors@4.4.0
exiflibnet@2.1.4
system.diagnostics.tools@4.3.0
microsoft.netcore.platforms@2.0.0
microsoft.netcore.platforms@3.1.0
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@5.0.0
glibsharp@3.24.24.38
system.data.sqlite.core@1.0.117
log4net@2.0.15
runtime.any.system.text.encoding@4.3.0
skiasharp.nativeassets.macos@2.88.3
runtime.any.system.text.encoding.extensions@4.3.0
system.threading@4.3.0
runtime.any.system.globalization@4.3.0
system.io.filesystem.primitives@4.3.0
sqlitepclraw.provider.dynamic_cdecl@2.0.4
system.diagnostics.diagnosticsource@4.3.0
microsoft.io.recyclablememorystream@2.3.2
microsoft.netframework.referenceassemblies.net461@1.0.3
system.reflection.metadata@1.6.0
utf.unknown@2.5.1
system.threading.tasks.extensions@4.3.0
portable.xaml@0.26.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
giosharp@3.24.24.38
system.runtime.extensions@4.3.0
runtime.unix.microsoft.win32.primitives@4.3.0
system.reflection.emit@4.3.0
system.linq@4.3.0
system.collections.concurrent@4.3.0
system.reflection.typeextensions@4.3.0
system.reflection.typeextensions@4.7.0
nuget.frameworks@6.5.0
mathnet.numerics.signed@4.15.0
system.io@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.2
runtime.native.system.security.cryptography.openssl@4.3.0
system.xml.xmldocument@4.3.0
skiasharp.nativeassets.win32@2.88.3
runtime.any.system.globalization.calendars@4.3.0
npoi@2.6.2
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.0
system.security.cryptography.x509certificates@4.3.0
gtksharp@3.24.24.38
sharpziplib@1.3.3
system.runtime.loader@4.3.0
system.net.webheadercollection@4.3.0
lucene.net.queryparser@4.8.0-beta00016
runtime.any.system.diagnostics.tools@4.3.0
system.windows.extensions@6.0.0
system.windows.extensions@4.7.0
system.security.principal.windows@4.3.0
system.security.principal.windows@4.5.0
system.security.principal.windows@4.7.0
nunit@3.13.3
system.security.cryptography.csp@4.3.0
system.collections@4.3.0
mono.nat@3.0.4
runtime.win-arm64.runtime.native.system.data.sqlclient.sni@4.4.0
system.net.http@4.3.0
gdksharp@3.24.24.38
microsoft.testplatform.testhost@17.6.2
runtime.any.system.threading.tasks@4.3.0
runtime.unix.system.net.primitives@4.3.0
runtime.any.system.resources.resourcemanager@4.3.0
lucene.net.analysis.common@4.8.0-beta00016
system.appcontext@4.3.0
microsoft.codecoverage@17.6.2
system.security.cryptography.encoding@4.3.0
system.diagnostics.tracing@4.3.0
system.reflection.primitives@4.3.0
skiasharp@2.88.3
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.any.system.diagnostics.tracing@4.3.0
system.data.sqlclient@4.8.1
microsoft.win32.systemevents@6.0.0
microsoft.win32.systemevents@4.7.0
system.data.sqlite.ef6@1.0.117
microsoft.netcore.targets@1.1.0
castle.core@5.0.0
runtime.any.system.threading.timer@4.3.0
system.runtime.compilerservices.unsafe@4.5.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.compilerservices.unsafe@4.4.0
system.runtime.compilerservices.unsafe@4.5.2
system.runtime.compilerservices.unsafe@4.7.0
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.interopservices@4.3.0
system.net.primitives@4.3.0
runtime.unix.system.console@4.3.0
system.xml.xdocument@4.3.0
system.threading.timer@4.3.0
system.security.cryptography.protecteddata@4.5.0
system.security.cryptography.protecteddata@6.0.0
system.security.cryptography.protecteddata@4.7.0
netstandard.library@2.0.0
netstandard.library@2.0.3
netstandard.library@1.6.1
sqlitepclraw.lib.e_sqlite3@2.0.4
system.security.cryptography.pkcs@6.0.1
sixlabors.fonts@1.0.0
pangosharp@3.24.24.38
system.runtime.numerics@4.3.0
runtime.unix.system.io.filesystem@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.2
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
system.reflection.emit.lightweight@4.3.0
system.globalization@4.3.0
j2n@2.0.0
microsoft.testplatform.objectmodel@17.6.2
"

inherit git-r3 dotnet-pkg

EGIT_COMMIT="425ff0cda8e4d5f140dd89c126504dcba0f3b646"
EGIT_REPO_URI="https://github.com/Serg-Norseman/GEDKeeper.git"

#EGIT_OVERRIDE_COMMIT_SERG_NORSEMAN_GEDKEEPER=""
EGIT_OVERRIDE_COMMIT_SERG_NORSEMAN_GKCOMMUNICATOR="49b3dd1f35b9240d58650f1ff1d8a2ba9ef9ad1b"
EGIT_OVERRIDE_COMMIT_SERG_NORSEMAN_GKGENETIX="c83cecc5b318a9ca73b52f3af18e39405fc017c3"


DESCRIPTION="Personal genealogical database"
HOMEPAGE="https://gedkeeper.github.io/"

SRC_URI+=" ${NUGET_URIS} "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

#dev-lang/mono
#
#	dev-dotnet/libgdiplus
RDEPEND="
	dev-db/sqlite"
DEPEND="${RDEPEND}"

IUSE="debug"

DOTNET_PKG_PROJECTS=( "${S}/projects/GKv3/GEDKeeper3.sln" )
DOTNET_PKG_RESTORE_EXTRA_ARGS=( -p:Platform="Linux" )
# https://github.com/dotnet/sdk/issues/14281
DOTNET_PKG_BUILD_EXTRA_ARGS=( /p:Platform="Linux" -p:ImportByWildcardBeforeSolution=false )

src_unpack() {
	dotnet-pkg_src_unpack

	if [[ -n "${EGIT_REPO_URI}" ]] ; then
		git-r3_src_unpack
	fi
}

#dotnet-pkg_src_compile() {
#	einfo "TEST: ${DOTNET_PROJECT}"
#	#overwrite default, it does not compile for some reason
#	edotnet build projects/GKv3/GEDKeeper3.sln /p:Configuration=Debug /p:Platform="Linux"
#}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/GEDKeeper3" "${PN}"
}
