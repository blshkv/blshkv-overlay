# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Ckeditor 4.x integration gem for rails"
HOMEPAGE="https://github.com/galetahub/ckeditor"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

ruby_add_rdepend "dev-ruby/orm_adapter"
