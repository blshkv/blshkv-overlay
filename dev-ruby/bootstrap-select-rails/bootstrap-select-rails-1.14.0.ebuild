# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://github.com/snapappointments/bootstrap-select/issues/2837
# bootstrap-select-v1.14.0-beta3-updated and bootstrap 5.3.0

HASH_COMMIT="d4fdc13c22759ca9acec028d72f35e133df6d932"

USE_RUBY="ruby31 ruby32"
#RUBY_FAKEGEM_RECIPE_DOC="rdoc"
# Requires capybara + poltergeist
#RUBY_FAKEGEM_RECIPE_TEST="none"
#RUBY_FAKEGEM_EXTRAINSTALL="assets"
#RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_EXTRAINSTALL="vendor"
RUBY_FAKEGEM_GEMSPEC="bootstrap-select-rails.gemspec"

inherit ruby-fakegem

DESCRIPTION="Bootstrap rubygem for Rails / Sprockets / Hanami / etc"
HOMEPAGE="https://github.com/twbs/bootstrap-rubygem"
LICENSE="MIT"

SRC_URI="https://github.com/blshkv/bootstrap-select-rails/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
RUBY_S="${PN}-${HASH_COMMIT}"

#wait for ~dev-ruby/sassc-rails
KEYWORDS="~amd64"
SLOT="0"

#ruby_add_rdepend "
#	>=dev-ruby/autoprefixer-rails-9.1.0
#	>=dev-ruby/popper_js-2.11.8:2
#"

#all_ruby_prepare() {
#	sed -i -e '/reporters/I s:^:#:' test/test_helper.rb || die
#}

all_ruby_prepare() {
	sed -i -e '/git ls-files/d' bootstrap-select-rails.gemspec || die
}
