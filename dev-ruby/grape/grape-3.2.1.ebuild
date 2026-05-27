# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

inherit ruby-fakegem

DESCRIPTION="A Ruby framework for rapid API development with great conventions"
HOMEPAGE="https://github.com/ruby-grape/grape"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	|| ( dev-ruby/activesupport:8.1 dev-ruby/activesupport:8.0 dev-ruby/activesupport:7.2 )
	dev-ruby/dry-configurable
	>=dev-ruby/dry-types-1.1
	=dev-ruby/mustermann-grape-1.1*
	>=dev-ruby/rack-2.0.0
	dev-ruby/zeitwerk
"
