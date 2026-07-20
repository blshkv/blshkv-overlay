# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Interactive shell in x86_64 Linux assembly, no libc, pure syscalls"
HOMEPAGE="https://github.com/isene/bare"
SRC_URI="https://github.com/isene/bare/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/bare-${PV}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="-* amd64"

BDEPEND="dev-lang/nasm"
RDEPEND="x11-misc/xdg-utils"

src_compile() {
	emake bare
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	insinto /usr/share/bare/plugins
	doins plugins/ask plugins/suggest
	fperms 0755 /usr/share/bare/plugins/ask /usr/share/bare/plugins/suggest
	einstalldocs
}

pkg_postinst() {
	if ! grep -q '^/usr/bin/bare$' "${EROOT}"/etc/shells; then
		ebegin "Updating /etc/shells"
		echo "/usr/bin/bare" >> "${EROOT}"/etc/shells
		eend $?
	fi
	elog "Plugins (ask, suggest) are installed to /usr/share/bare/plugins/."
	elog "Copy them to ~/.bare/plugins/ to activate."
}

pkg_postrm() {
	if grep -q '^/usr/bin/bare$' "${EROOT}"/etc/shells; then
		ebegin "Updating /etc/shells"
		sed -i -e '\:^/usr/bin/bare$:d' "${EROOT}"/etc/shells
		eend $?
	fi
}
