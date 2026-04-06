# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="OpenAI API client for Ruby"
HOMEPAGE="https://github.com/openai/openai-ruby"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/connection_pool-2.5.0
"
