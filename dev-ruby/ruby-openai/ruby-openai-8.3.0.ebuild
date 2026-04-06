# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Ruby bindings for the OpenAI API"
HOMEPAGE="https://github.com/alexrudall/ruby-openai"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/event_stream_parser-0.3.0:0
	>=dev-ruby/faraday-1.0.0
	>=dev-ruby/faraday-multipart-1.0.0
"
