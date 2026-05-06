# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_EXTRAINSTALL="vendor"

inherit ruby-fakegem

DESCRIPTION="Use CodeMirror with Rails"
HOMEPAGE="https://github.com/fixlr/codemirror-rails"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RESTRICT="test"

ruby_add_rdepend "
	|| ( dev-ruby/railties:8.1 dev-ruby/railties:8.0 dev-ruby/railties:7.2 dev-ruby/railties:7.1 )
"
