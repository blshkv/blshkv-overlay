# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# core_lib/Cargo.lock was used to generate CRATES.

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anyhow@1.0.94
	async-trait@0.1.83
	autocfg@1.4.0
	backtrace@0.3.74
	base16ct@0.2.0
	base64@0.22.1
	base64ct@1.6.0
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	block2@0.5.1
	bluer@0.17.3
	bluez-async@0.7.2
	bluez-generated@0.3.0
	btleplug@0.11.6
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.9.0
	c_linked_list@1.1.1
	cc@1.2.5
	cesu8@1.1.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.39
	combine@4.6.7
	concurrent-queue@2.5.0
	const-oid@0.9.6
	core-foundation-sys@0.8.7
	cpufeatures@0.2.16
	crossbeam-utils@0.8.21
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	custom_debug@0.6.2
	custom_debug_derive@0.6.2
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dashmap@5.5.3
	dashmap@6.1.0
	dbus-crossroads@0.5.2
	dbus-tokio@0.7.6
	dbus@0.9.7
	der@0.7.9
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.2.5
	ecdsa@0.16.9
	either@1.13.0
	elliptic-curve@0.13.8
	equivalent@1.0.1
	errno@0.3.10
	fastrand@2.3.0
	ff@0.13.0
	fixedbitset@0.4.2
	flume@0.11.1
	fnv@1.0.7
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	gcc@0.3.55
	generic-array@0.14.7
	get_if_addrs-sys@0.1.1
	get_if_addrs@0.5.3
	getrandom@0.2.15
	gimli@0.31.1
	glob@0.3.1
	group@0.13.0
	hashbrown@0.14.5
	hashbrown@0.15.2
	heck@0.5.0
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	ident_case@1.0.1
	if-addrs@0.10.2
	indexmap@2.7.0
	io-kit-sys@0.3.0
	itertools@0.10.5
	itertools@0.13.0
	itoa@1.0.14
	jni-sys@0.3.0
	jni-utils@0.1.1
	jni@0.19.0
	js-sys@0.3.76
	lazy_static@1.5.0
	libaes@0.7.0
	libc@0.2.169
	libdbus-sys@0.2.5
	libredox@0.1.3
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	macaddr@1.0.1
	mach2@0.4.2
	mach@0.3.2
	matchers@0.1.0
	memchr@2.7.4
	mime@0.3.17
	mime_guess@2.0.5
	miniz_oxide@0.8.2
	mio@1.0.3
	multimap@0.10.0
	nix@0.29.0
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-traits@0.2.19
	objc-sys@0.3.5
	objc2-core-bluetooth@0.2.2
	objc2-encode@4.0.3
	objc2-foundation@0.2.2
	objc2@0.5.2
	object@0.36.5
	once_cell@1.20.2
	option-ext@0.2.0
	overload@0.1.1
	p256@0.13.2
	parking_lot_core@0.9.10
	pem-rfc7468@0.7.0
	petgraph@0.6.5
	pin-project-internal@1.1.7
	pin-project-lite@0.2.15
	pin-project@1.1.7
	pin-utils@0.1.0
	pkcs8@0.10.2
	pkg-config@0.3.31
	polling@2.8.0
	ppv-lite86@0.2.20
	prettyplease@0.2.25
	primeorder@0.13.6
	proc-macro2@1.0.92
	prost-build@0.13.4
	prost-derive@0.13.4
	prost-types@0.13.4
	prost@0.13.4
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.8
	redox_users@0.4.6
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	regex@1.11.1
	rfc6979@0.4.0
	rustc-demangle@0.1.24
	rustix@0.38.42
	rustversion@1.0.18
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	sec1@0.7.3
	serde-xml-rs@0.6.0
	serde@1.0.216
	serde_derive@1.0.216
	serde_json@1.0.133
	sha2@0.10.8
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signature@2.2.0
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.4.10
	socket2@0.5.8
	spin@0.9.8
	spki@0.7.3
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	subtle@2.6.1
	syn@2.0.90
	synstructure@0.13.1
	tempfile@3.14.0
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror-impl@2.0.8
	thiserror@1.0.69
	thiserror@2.0.8
	thread_local@1.1.8
	tokio-macros@2.4.0
	tokio-stream@0.1.17
	tokio-util@0.7.13
	tokio@1.42.0
	tracing-core@0.1.33
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	ts-rs-macros@10.1.0
	ts-rs@10.1.0
	typenum@1.17.0
	unicase@2.8.0
	unicode-ident@1.0.14
	uuid@1.11.0
	valuable@0.1.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.99
	wasm-bindgen-macro-support@0.2.99
	wasm-bindgen-macro@0.2.99
	wasm-bindgen-shared@0.2.99
	wasm-bindgen@0.2.99
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.57.0
	windows-implement@0.57.0
	windows-interface@0.57.0
	windows-result@0.1.2
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.57.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	xml-rs@0.8.24
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
"

MDNS_SD_COMMIT="c3d6ec2e173ac2cf8306943f70026c37c2ab1dd7"
SYS_METRICS_COMMIT="e5b324a17d1724bd97923a173c3535cc06a44b0c"

RUST_MIN_VER="1.75"

inherit cargo

DESCRIPTION="Quick Share (Nearby Share) implementation for Linux"
HOMEPAGE="https://github.com/Martichou/rquickshare"

SRC_URI="
	https://github.com/Martichou/rquickshare/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/Martichou/mdns-sd/archive/${MDNS_SD_COMMIT}.tar.gz -> mdns-sd-${MDNS_SD_COMMIT::8}.gh.tar.gz
	https://github.com/Martichou/sys_metrics/archive/${SYS_METRICS_COMMIT}.tar.gz -> sys_metrics-${SYS_METRICS_COMMIT::8}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/rquickshare-${PV}/core_lib"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
# does not work, "Unhandled offline frame encrypted"
#KEYWORDS="amd64"

RDEPEND="
	sys-apps/dbus
	net-wireless/bluez
"
DEPEND="${RDEPEND}"
BDEPEND="dev-libs/protobuf"

QA_FLAGS_IGNORED="/usr/bin/rquickshare"

src_unpack() {
	unpack "${P}.gh.tar.gz"
	unpack "mdns-sd-${MDNS_SD_COMMIT::8}.gh.tar.gz"
	unpack "sys_metrics-${SYS_METRICS_COMMIT::8}.gh.tar.gz"
	cargo_src_unpack
}

src_prepare() {
	default

	# Replace git dependencies with local paths from SRC_URI tarballs
	sed -i \
		-e "s|mdns-sd = { git = \"https://github.com/Martichou/mdns-sd\", branch = \"unsolicited\" }|mdns-sd = { path = \"${WORKDIR}/mdns-sd-${MDNS_SD_COMMIT}\" }|" \
		-e "s|sys_metrics = { git = \"https://github.com/Martichou/sys_metrics\" }|sys_metrics = { path = \"${WORKDIR}/sys_metrics-${SYS_METRICS_COMMIT}\" }|" \
		Cargo.toml || die

	# core_bin has no UI to handle transfer consent requests. Subscribe to the
	# broadcast channel and auto-accept all incoming transfers in daemon mode.
	eapply "${FILESDIR}/${P}-auto-accept.patch"
}

src_install() {
	cargo_src_install --bin core_bin
	mv "${ED}/usr/bin/core_bin" "${ED}/usr/bin/rquickshare" || die
	dodoc "${WORKDIR}/rquickshare-${PV}/README.md"
}
