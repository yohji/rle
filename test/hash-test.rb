#
#   Copyright (c) 2018 Marco Merli <yohji@marcomerli.net>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#   or see <http://www.gnu.org/licenses/>
#

require "test/unit"
load "lib/rle/hash.rb"

class HashcodeTest < Test::Unit::TestCase
	include Hashcode

	def test_murmur3_32
		assert_equal(0x087fcd5c, Hashcode.murmur3_32(""))
		assert_equal(0x8ee776ee, Hashcode.murmur3_32("Z"))
		assert_equal(0x890ca77b, Hashcode.murmur3_32("!?"))
		assert_equal(0xe8daf3dd, Hashcode.murmur3_32("[|]"))
		assert_equal(0x1b12f10d, Hashcode.murmur3_32("ABCD"))
		assert_equal(0x8430f6fe, Hashcode.murmur3_32("yohji"))
	end
end
