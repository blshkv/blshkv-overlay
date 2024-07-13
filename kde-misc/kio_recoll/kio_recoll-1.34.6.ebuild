# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kde.org

DESCRIPTION="Recoll KIO slave"
HOMEPAGE="http://www.lesbonscomptes.com/recoll/"
SRC_URI="http://www.lesbonscomptes.com/recoll/recoll-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/recoll-${PV}/kde/kioslave/${PN}"

DEPEND=""
#	>=media-libs/libmtp-1.1.3
#"
RDEPEND="${DEPEND}"
