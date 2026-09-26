# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

inherit ruby-fakegem

DESCRIPTION="Swagger UI integration for Grape APIs"
HOMEPAGE="https://github.com/ruby-grape/grape-swagger"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/grape-2.1:0
"
