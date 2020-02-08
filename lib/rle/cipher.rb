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

module Cipher

	CHAR_UPCASE = 65
	CHAR_DOWNCASE = 97

	def Cipher.caesar_crypt(msg, shift)

		res = String.new
		msg.each_char do |ch|
			n = ch.ord

			if n >= CHAR_UPCASE and n < (CHAR_UPCASE + 26)
				n = (((n - CHAR_UPCASE) + shift) % 26) + CHAR_UPCASE
			elsif n >= CHAR_DOWNCASE and n < (CHAR_DOWNCASE + 26)
				n = (((n - CHAR_DOWNCASE) + shift) % 26) + CHAR_DOWNCASE
			end

			res += n.chr(Encoding::UTF_8)
		end

		return res
	end

	def Cipher.caesar_decrypt(msg, shift)

		res = String.new
		msg.each_char do |ch|
			n = ch.ord

			if n >= CHAR_UPCASE and n < (CHAR_UPCASE + 26)
				n = (((n - CHAR_UPCASE) - shift) % 26) + CHAR_UPCASE
			elsif n >= CHAR_DOWNCASE and n < (CHAR_DOWNCASE + 26)
				n = (((n - CHAR_DOWNCASE) - shift) % 26) + CHAR_DOWNCASE
			end

			res += n.chr(Encoding::UTF_8)
		end

		return res
	end

	def Cipher.xor_crypt(msg, key)

		res = String.new
		bytes = msg.unpack("S*")

		bytes.each do |b| # 16bit
			buffer = (b ^ key)
			res += (buffer & 0xff).chr
			res += (buffer >> 8).chr
		end

		return res
	end

	def Cipher.xor_decrypt(msg, key)

		res = String.new
		bytes = msg.unpack("S*")

		bytes.each do |b| # 16bit
			buffer = (b ^ key)
			res += (buffer & 0xff).chr
			res += (buffer >> 8).chr
		end

		return res
	end
end
