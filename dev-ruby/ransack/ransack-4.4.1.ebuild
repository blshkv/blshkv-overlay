# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Powerful object-based searching and filtering for Active Record"
HOMEPAGE="https://github.com/activerecord-hackery/ransack"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RESTRICT="test"

ruby_add_rdepend "
	|| ( dev-ruby/activerecord:8.1 dev-ruby/activerecord:8.0 dev-ruby/activerecord:7.2 )
	|| ( dev-ruby/activesupport:8.1 dev-ruby/activesupport:8.0 dev-ruby/activesupport:7.2 )
	dev-ruby/i18n
"
