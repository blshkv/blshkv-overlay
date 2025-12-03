# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="CKEditor 5 for Rails"
HOMEPAGE="https://rubygems.org/gems/ckeditor5 https://github.com/Mati365/ckeditor5-rails"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

ruby_add_rdepend "dev-ruby/terser"
