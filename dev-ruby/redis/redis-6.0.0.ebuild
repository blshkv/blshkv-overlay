# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

MY_P="redis-rb-${PV}"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A Ruby client library for Redis"
HOMEPAGE="https://github.com/redis/redis-rb"
SRC_URI="https://github.com/redis/redis-rb/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="6"
KEYWORDS="amd64 ~arm64"

RUBY_S="${MY_P}"

ruby_add_rdepend "=dev-ruby/redis-client-0.30*"

