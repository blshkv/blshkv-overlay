# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_GEMSPEC="redis-client.gemspec"

inherit ruby-fakegem

DESCRIPTION="Simple low-level Redis client"
HOMEPAGE="https://github.com/redis-rb/redis-client"
SRC_URI="https://github.com/redis-rb/redis-client/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"

ruby_add_rdepend ">=dev-ruby/connection_pool-2.3:3"

all_ruby_prepare() {
	sed -i \
		-e '/require_relative.*version/d' \
		-e 's/RedisClient::VERSION/"0.30.1"/' \
		-e '/spec\.files = Dir\.chdir/,/^  end$/d' \
		${RUBY_FAKEGEM_GEMSPEC} || die
}

