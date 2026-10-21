# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

GITHUB_REPOSITORY="nozwock/packet"
GITHUB_TAG="0.6.1"
inherit cargo meson gnome2-utils python-single-r1 github-archive

DESCRIPTION="Quick Share (NearDrop) client for Linux using GTK4 and Libadwaita"
HOMEPAGE="https://github.com/nozwock/packet"
#EGIT_REPO_URI="https://github.com/nozwock/packet.git"

LICENSE="GPL-3+"
SLOT="0"
#KEYWORDS=""
IUSE="nautilus"

REQUIRED_USE="nautilus? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
    >=dev-libs/glib-2.76.0:2
    >=gui-libs/gtk-4.12.0:4
    >=gui-libs/libadwaita-1.4.0:1
    sys-apps/dbus
    nautilus? (
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
	    dev-python/dbus-python[${PYTHON_USEDEP}]
	')
	gnome-extra/nautilus-python
    )
"
DEPEND="${RDEPEND}"
BDEPEND="
    dev-util/blueprint-compiler
    dev-util/glib-utils
    virtual/pkgconfig
"

pkg_setup() {
    if use nautilus; then
	python-single-r1_pkg_setup
    fi
}

#src_unpack() {
#    git-r3_src_unpack
#    cargo_live_src_unpack
#}

#src_configure() {
#    local emesonargs=(
#	$(meson_use nautilus nautilus_extension)
#    )
#    meson_src_configure
#}

src_compile() {
    meson_src_compile
}

src_install() {
    meson_src_install
}

pkg_postinst() {
    gnome2_schemas_update
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    gnome2_schemas_update
    xdg_desktop_database_update
    xdg_icon_cache_update
}
