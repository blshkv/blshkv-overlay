# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..13} )

# app-portage/pycargoebuild
# generate: cd crates/jiter-python; pycargoebuild .
CRATES="
	ahash@0.8.11
	arbitrary@1.4.1
	autocfg@1.4.0
	bencher@0.1.5
	bitvec@1.0.1
	cc@1.2.2
	cfg-if@1.0.0
	codspeed-bencher-compat@2.7.2
	codspeed@2.7.2
	colored@2.1.0
	equivalent@1.0.1
	funty@2.0.0
	getrandom@0.2.15
	hashbrown@0.15.2
	heck@0.5.0
	indexmap@2.7.0
	indoc@2.0.5
	itoa@1.0.14
	jobserver@0.1.32
	lazy_static@1.5.0
	lexical-parse-float@0.8.5
	lexical-parse-integer@0.8.6
	lexical-util@0.8.5
	libc@0.2.167
	libfuzzer-sys@0.4.8
	memchr@2.7.4
	memoffset@0.9.1
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.20.2
	paste@1.0.15
	portable-atomic@1.10.0
	proc-macro2@1.0.92
	pyo3-build-config@0.23.3
	pyo3-ffi@0.23.3
	pyo3-macros-backend@0.23.3
	pyo3-macros@0.23.3
	pyo3@0.23.3
	python3-dll-a@0.2.11
	quote@1.0.37
	radium@0.7.0
	ryu@1.0.18
	serde@1.0.215
	serde_derive@1.0.215
	serde_json@1.0.133
	shlex@1.3.0
	smallvec@1.13.2
	static_assertions@1.1.0
	syn@2.0.90
	tap@1.0.1
	target-lexicon@0.12.16
	unicode-ident@1.0.14
	unindent@0.2.3
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	wyz@0.5.1
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Fast iterable JSON parser."
HOMEPAGE="https://github.com/pydantic/jiter/"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

#RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
