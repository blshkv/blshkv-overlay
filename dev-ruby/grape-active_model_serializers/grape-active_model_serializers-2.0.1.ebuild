# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Provides a Formatter for the Grape API DSL"
HOMEPAGE="https://github.com/ruby-grape/grape-active_model_serializers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/active_model_serializers-0.10.0
	>=dev-ruby/grape-2.3.0
"
