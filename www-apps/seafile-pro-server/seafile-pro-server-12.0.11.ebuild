# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit python-single-r1

MY_P="seafile-pro-server_${PV}_x86-64_Ubuntu.tar.gz"

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://www.seafile.com/en/product/private_server/"
SRC_URI="https://download.seafile.com/d/6e5297246c/files/?p=%2Fpro%2F${MY_P}&dl=1 -> ${MY_P}"

LICENSE="seafile"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fuse +ldap mariadb mysql psd saml"

# https://manual.seafile.com/12.0/changelog/changelog-for-seafile-professional-server/

RDEPEND="${PYTHON_DEPS}
	=app-misc/elasticsearch-8*
	$(python_gen_cond_dep '
	=dev-python/django-4.2*[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.0[${PYTHON_USEDEP}]
	dev-python/pylibmc[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]

	dev-python/jinja2[${PYTHON_USEDEP}]
	>dev-python/sqlalchemy-2.0.18[${PYTHON_USEDEP}]
	psd? ( dev-python/psd-tools )
	dev-python/django-pylibmc[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]

	dev-python/lxml[${PYTHON_USEDEP}]

	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cffi
	dev-python/requests

	')
	fuse? ( sys-fs/fuse:0 )
	ldap? ( $(python_gen_cond_dep ' dev-python/python-ldap[${PYTHON_USEDEP}]') )
	mariadb? ( $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_USEDEP}]') )
	mysql? ( $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_USEDEP}]') )
	saml?  ( $(python_gen_cond_dep ' dev-python/djangosaml2[${PYTHON_USEDEP}]') )
	sys-libs/libselinux
	dev-libs/nss
	virtual/jre:*"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	#eapply "${FILESDIR}"/pillow-10.patch
	#match with cffi in RDEPEND section
#	sed -e "s|1.14.0|${CFFI_PV}|" -i seahub/thirdpart/cffi/__init__.py || die "sed failed"
	rm -r seahub/thirdpart/{cffi*,requests*}
	eapply_user

# FIXME: add the following patch:
# https://forum.seafile.com/t/fresh-seahub-11-0-2-install-seahub-failed-to-start/18981/5
# /opt/seafile/seafile-server-11.0.3/seahub/seahub/utils/init .py Line 577
# -except ImportError:
# +except :

}

pkg_postinst() {
	elog "follow the official documentation:"
	elog "https://manual.seafile.com/12.0/setup/setup_pro_by_docker/"
	elog "https://manual.seafile.com/12.0/upgrade/upgrade_notes_for_12.0.x/"
}
