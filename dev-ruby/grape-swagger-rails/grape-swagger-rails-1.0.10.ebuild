# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

inherit ruby-fakegem

DESCRIPTION="Swagger UI as a Rails engine for grape-swagger"
HOMEPAGE="https://github.com/ruby-grape/grape-swagger-rails"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	=dev-ruby/haml-rails-2*
	>=dev-ruby/json-2.0:2
	>=dev-ruby/ostruct-0.6:0.6
	|| ( dev-ruby/railties:8.0 dev-ruby/railties:7.2 )
"
