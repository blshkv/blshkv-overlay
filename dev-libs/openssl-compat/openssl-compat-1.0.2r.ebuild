# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs multilib-minimal

# openssl-1.0.2-patches-1.6 contain additional CVE patches
# which got fixed with this release.
# Please use 1.7 version number when rolling a new tarball!
PATCH_SET="openssl-1.0.2-patches-1.5"

MY_P=openssl-${PV/_/-}

DESCRIPTION="full-strength general purpose cryptography library (including SSL and TLS)"
HOMEPAGE="https://www.openssl.org/"
SRC_URI="mirror://openssl/source/${MY_P}.tar.gz
	!vanilla? (
		mirror://gentoo/${PATCH_SET}.tar.xz
		https://dev.gentoo.org/~chutzpah/dist/openssl/${PATCH_SET}.tar.xz
		https://dev.gentoo.org/~whissi/dist/openssl/${PATCH_SET}.tar.xz
		https://dev.gentoo.org/~polynomial-c/dist/${PATCH_SET}.tar.xz
	)"

LICENSE="openssl"
SLOT="1.0.0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-linux"
IUSE="+asm bindist gmp kerberos rfc3779 sctp cpu_flags_x86_sse2 sslv2 +sslv3 static-libs test +tls-heartbeat vanilla zlib"
RESTRICT="!bindist? ( bindist )"

RDEPEND=">=app-misc/c_rehash-1.7-r1
	gmp? ( >=dev-libs/gmp-5.1.3-r1[static-libs(+)?,${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[static-libs(+)?,${MULTILIB_USEDEP}] )
	kerberos? ( >=app-crypt/mit-krb5-1.11.4[${MULTILIB_USEDEP}] )
	!=dev-libs/openssl-1.0.2*:0
	!dev-libs/openssl:1.0.0"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sctp? ( >=net-misc/lksctp-tools-1.0.12 )
	test? (
		sys-apps/diffutils
		sys-devel/bc
	)"

RESTRICT="test"

# Do not install any docs
DOCS=()

# This does not copy the entire Fedora patchset, but JUST the parts that
# are needed to make it safe to use EC with RESTRICT=bindist.
# See openssl.spec for the matching numbering of SourceNNN, PatchNNN
#SOURCE1=hobble-openssl
SOURCE12=ec_curve.c
SOURCE13=ectest.c
# These are ported instead
#PATCH1=openssl-1.1.0-build.patch # Fixes EVP testcase for EC
#PATCH37=openssl-1.1.0-ec-curves.patch
FEDORA_GIT_BASE='https://src.fedoraproject.org/cgit/rpms/openssl.git/plain/'
FEDORA_GIT_BRANCH='f25'
FEDORA_SRC_URI=()
FEDORA_SOURCE=( $SOURCE1 $SOURCE12 $SOURCE13 )
FEDORA_PATCH=( $PATCH1 $PATCH37 )
for i in "${FEDORA_SOURCE[@]}" ; do
	FEDORA_SRC_URI+=( "${FEDORA_GIT_BASE}/${i}?h=${FEDORA_GIT_BRANCH} -> openssl-${PV}_${i}" )
done
for i in "${FEDORA_PATCH[@]}" ; do # Already have a version prefix
	FEDORA_SRC_URI+=( "${FEDORA_GIT_BASE}/${i}?h=${FEDORA_GIT_BRANCH} -> ${i}" )
done
SRC_URI+=" bindist? ( ${FEDORA_SRC_URI[@]} )"

S="${WORKDIR}/${MY_P}"

MULTILIB_WRAPPED_HEADERS=(
	usr/include/openssl/opensslconf.h
)

src_prepare() {
	if use bindist; then
		# This just removes the prefix, and puts it into WORKDIR like the RPM.
		for i in "${FEDORA_SOURCE[@]}" ; do
			cp -f "${DISTDIR}"/"openssl-${PV}_${i}" "${WORKDIR}"/"${i}" || die
		done
		# .spec %prep
		bash "${WORKDIR}"/"${SOURCE1}" || die
		cp -f "${WORKDIR}"/"${SOURCE12}" "${S}"/crypto/ec/ || die
		cp -f "${WORKDIR}"/"${SOURCE13}" "${S}"/crypto/ec/ || die # Moves to test/ in OpenSSL-1.1
		for i in "${FEDORA_PATCH[@]}" ; do
			eapply "${DISTDIR}"/"${i}"
		done
		eapply "${FILESDIR}"/openssl-1.0.2p-hobble-ecc.patch
		# Also see the configure parts below:
		# enable-ec \
		# $(use_ssl !bindist ec2m) \
		# $(use_ssl !bindist srp) \
	fi

	# keep this in sync with app-misc/c_rehash
	SSL_CNF_DIR="/etc/ssl"

	# Make sure we only ever touch Makefile.org and avoid patching a file
	# that gets blown away anyways by the Configure script in src_configure
	rm -f Makefile

	if ! use vanilla ; then
		eapply "${WORKDIR}"/patch/*.patch
	fi

	eapply_user

	# disable fips in the build
	# make sure the man pages are suffixed #302165
	# don't bother building man pages if they're disabled
	sed -i \
		-e '/DIRS/s: fips : :g' \
		-e '/^MANSUFFIX/s:=.*:=ssl:' \
		-e '/^MAKEDEPPROG/s:=.*:=$(CC):' \
		-e $(has noman FEATURES \
			&& echo '/^install:/s:install_docs::' \
			|| echo '/^MANDIR=/s:=.*:='${EPREFIX}'/usr/share/man:') \
		Makefile.org \
		|| die
	# show the actual commands in the log
	sed -i '/^SET_X/s:=.*:=set -x:' Makefile.shared

	# since we're forcing $(CC) as makedep anyway, just fix
	# the conditional as always-on
	# helps clang (#417795), and versioned gcc (#499818)
	# this breaks build with 1.0.2p, not sure if it is needed anymore
	#sed -i 's/expr.*MAKEDEPEND.*;/true;/' util/domd || die

	# quiet out unknown driver argument warnings since openssl
	# doesn't have well-split CFLAGS and we're making it even worse
	# and 'make depend' uses -Werror for added fun (#417795 again)
	[[ ${CC} == *clang* ]] && append-flags -Qunused-arguments

	# allow openssl to be cross-compiled
	cp "${FILESDIR}"/gentoo.config-1.0.2 gentoo.config || die
	chmod a+rx gentoo.config || die

	append-flags -fno-strict-aliasing
	append-flags $(test-flags-CC -Wa,--noexecstack)
	append-cppflags -DOPENSSL_NO_BUF_FREELISTS

	sed -i '1s,^:$,#!'${EPREFIX}'/usr/bin/perl,' Configure #141906
	# The config script does stupid stuff to prompt the user.  Kill it.
	sed -i '/stty -icanon min 0 time 50; read waste/d' config || die
	./config --test-sanity || die "I AM NOT SANE"

	multilib_copy_sources
}

multilib_src_configure() {
	unset APPS #197996
	unset SCRIPTS #312551
	unset CROSS_COMPILE #311473

	tc-export CC AR RANLIB RC

	# Clean out patent-or-otherwise-encumbered code
	# Camellia: Royalty Free            https://en.wikipedia.org/wiki/Camellia_(cipher)
	# IDEA:     Expired                 https://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm
	# EC:       ????????? ??/??/2015    https://en.wikipedia.org/wiki/Elliptic_Curve_Cryptography
	# MDC2:     Expired                 https://en.wikipedia.org/wiki/MDC-2
	# RC5:      Expired                 https://en.wikipedia.org/wiki/RC5

	use_ssl() { usex $1 "enable-${2:-$1}" "no-${2:-$1}" " ${*:3}" ; }
	echoit() { echo "$@" ; "$@" ; }

	local krb5=$(has_version app-crypt/mit-krb5 && echo "MIT" || echo "Heimdal")

	# See if our toolchain supports __uint128_t.  If so, it's 64bit
	# friendly and can use the nicely optimized code paths. #460790
	local ec_nistp_64_gcc_128
	# Disable it for now though #469976
	#if ! use bindist ; then
	#	echo "__uint128_t i;" > "${T}"/128.c
	#	if ${CC} ${CFLAGS} -c "${T}"/128.c -o /dev/null >&/dev/null ; then
	#		ec_nistp_64_gcc_128="enable-ec_nistp_64_gcc_128"
	#	fi
	#fi

	local sslout=$(./gentoo.config)
	einfo "Use configuration ${sslout:-(openssl knows best)}"
	local config="Configure"
	[[ -z ${sslout} ]] && config="config"

	# Fedora hobbled-EC needs 'no-ec2m', 'no-srp'
	# Make sure user flags don't get added *yet* to avoid duplicated
	# flags.
	CFLAGS= LDFLAGS= echoit \
	./${config} \
		${sslout} \
		$(use cpu_flags_x86_sse2 || echo "no-sse2") \
		enable-camellia \
		enable-ec \
		$(use_ssl !bindist ec2m) \
		$(use_ssl !bindist srp) \
		${ec_nistp_64_gcc_128} \
		enable-idea \
		enable-mdc2 \
		enable-rc5 \
		enable-tlsext \
		$(use_ssl asm) \
		$(use_ssl gmp gmp -lgmp) \
		$(use_ssl kerberos krb5 --with-krb5-flavor=${krb5}) \
		$(use_ssl rfc3779) \
		$(use_ssl sctp) \
		$(use_ssl sslv2 ssl2) \
		$(use_ssl sslv3 ssl3) \
		$(use_ssl tls-heartbeat heartbeats) \
		$(use_ssl zlib) \
		--prefix="${EPREFIX}"/usr \
		--openssldir="${EPREFIX}"${SSL_CNF_DIR} \
		--libdir=$(get_libdir) \
		shared threads \
		|| die

	# Clean out hardcoded flags that openssl uses
	local DEFAULT_CFLAGS=$(grep ^CFLAG= Makefile | LC_ALL=C sed \
		-e 's:^CFLAG=::' \
		-e 's:-fomit-frame-pointer ::g' \
		-e 's:-O[0-9] ::g' \
		-e 's:-march=[-a-z0-9]* ::g' \
		-e 's:-mcpu=[-a-z0-9]* ::g' \
		-e 's:-m[a-z0-9]* ::g' \
	)
	sed -i \
		-e "/^CFLAG/s|=.*|=${DEFAULT_CFLAGS} ${CFLAGS}|" \
		-e "/^SHARED_LDFLAGS=/s|$| ${LDFLAGS}|" \
		Makefile || die
}

multilib_src_compile() {
	# depend is needed to use $confopts; it also doesn't matter
	# that it's -j1 as the code itself serializes subdirs
	emake -j1 V=1 depend
	emake build_libs
}

multilib_src_test() {
	emake -j1 test
}

multilib_src_install() {
	dolib.so lib{crypto,ssl}.so.${SLOT}
}
