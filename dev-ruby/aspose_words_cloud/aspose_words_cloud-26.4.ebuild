# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"

RUBY_FAKEGEM_RECIPE_TEST="none"

inherit ruby-fakegem

DESCRIPTION="Ruby SDK for Aspose.Words Cloud REST API"
HOMEPAGE="https://products.aspose.cloud/words/family/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/faraday-1.9.3:1
	>=dev-ruby/marcel-1.0.0
	>=dev-ruby/multipart-parser-0.1.1
"
