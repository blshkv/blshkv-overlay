# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby33 ruby34 ruby40"

RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_GEMSPEC="cvss_suite.gemspec"

inherit ruby-fakegem

DESCRIPTION="Ruby gem for processing CVSS vectors (v2, v3.0, v3.1, v4.0)"
HOMEPAGE="https://cvss-suite.0lli.rocks https://github.com/0llirocks/cvss-suite"
SRC_URI="https://github.com/0llirocks/cvss-suite/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

ruby_add_rdepend ">=dev-ruby/bigdecimal-3.1"
ruby_add_bdepend "test? ( dev-ruby/rspec-its )"
