# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{12..13} )
inherit python-single-r1 python-utils-r1

HASH_COMMIT="0ee4d11f06d77765d777c0cf90e34278db99e621"

DESCRIPTION="Real-Time User-Guided Image Colorization with Learned Deep Priors"
HOMEPAGE="https://richzhang.github.io/ideepcolor/"
SRC_URI="https://github.com/junyanz/interactive-deep-colorization/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda +gui"

#dev-libs/caffe[python,cuda?]
#	sci-libs/scikits_learn
RDEPEND="
	media-libs/opencv[python]"
#	dev-python/jsonschema[${PYTHON_USEDEP}]"
#	gui? ( dev-python/PyQt5[${PYTHON_USEDEP}]
#		dev-python/qdarkstyle[${PYTHON_USEDEP}]
#	)"

DEPEND="${RDEPEND}"

src_prepare(){
	einfo "================> `pwd`"
	eapply -p2 "${FILESDIR}"/qt5.patch
	eapply_user
}

src_install(){
	insinto /usr/share/"${PN}"
	doins -r .
#	dobin "${FILESDIR}/${PN}"
	python_foreach_impl python_doexe ideepcolor.py
}
