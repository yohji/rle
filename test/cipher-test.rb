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
load "lib/rle/cipher.rb"

TEXT="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

class CipherTest < Test::Unit::TestCase

	def test_caesar
		(1 .. 26).each do |shift|

			secret = Cipher.caesar_crypt(TEXT, shift)
			plain = Cipher.caesar_decrypt(secret, shift)

			assert_equal(TEXT, plain)
		end
	end

	def test_xor
		(1 .. 9999).each do |key|

			secret = Cipher.xor_crypt(TEXT, key)
			plain = Cipher.xor_decrypt(secret, key)

			assert_equal(TEXT.size, plain.size)
			assert_equal(TEXT, plain, "key: #{key}")
		end
	end
end
