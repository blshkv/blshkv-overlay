# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="A mixin to add configuration functionality to your classes"
HOMEPAGE="https://github.com/dry-rb/dry-configurable"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/dry-core-1.1
	dev-ruby/zeitwerk
"
