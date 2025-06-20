# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_BINDIR="exe"

inherit ruby-fakegem

DESCRIPTION="Document template processor of Microsoft XML format (docx)"
HOMEPAGE="https://github.com/senny/sablon"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/nokogiri-1.8.5
	>=dev-ruby/rubyzip-1.3.1
"
