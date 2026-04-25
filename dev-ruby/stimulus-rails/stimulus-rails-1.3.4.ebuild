# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Use Stimulus.js with Ruby on Rails"
HOMEPAGE="https://github.com/hotwired/stimulus-rails"
SRC_URI="https://github.com/hotwired/stimulus-rails/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RESTRICT="test"

all_ruby_prepare() {
	eapply "${FILESDIR}/${P}-fix-gemspec-require.patch"
}

ruby_add_rdepend "
	|| ( dev-ruby/railties:8.1 dev-ruby/railties:8.0 dev-ruby/railties:7.2 dev-ruby/railties:7.1 )
"
