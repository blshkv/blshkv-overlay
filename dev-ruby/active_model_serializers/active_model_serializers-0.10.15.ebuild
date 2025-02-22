# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="Generate JSON in an object-oriented and convention-driven manner"
HOMEPAGE="https://github.com/rails-api/active_model_serializers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	<dev-ruby/actionpack-7.1
	<dev-ruby/activemodel-7.1
	>=dev-ruby/case_transform-0.2
	<dev-ruby/jsonapi-renderer-0.3
"
