#--
#--   Copyright (c) 2018 Marco Merli <yohji@marcomerli.net>
#--
#--   This program is free software; you can redistribute it and/or modify
#--   it under the terms of the GNU Lesser General Public License as published by
#--   the Free Software Foundation; either version 2 of the License, or
#--   (at your option) any later version.
#--
#--   This program is distributed in the hope that it will be useful,
#--   but WITHOUT ANY WARRANTY; without even the implied warranty of
#--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#--   GNU Lesser General Public License for more details.
#--
#--   You should have received a copy of the GNU Lesser General Public License
#--   along with this program; if not, write to the Free Software Foundation,
#--   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#--   or see <http://www.gnu.org/licenses/>
#--

module Rle
	module Cipher

		CH_UP = 65
		CH_DN = 97

		def Cipher.rot_enc(msg, shift = 13)
			res = String.new
			msg.each_char do |ch|
				n = ch.ord

				if n.between? CH_UP, (CH_UP + 25)
					n = (((n - CH_UP) + shift) % 26) + CH_UP
				elsif n.between? CH_DN, (CH_DN + 25)
					n = (((n - CH_DN) + shift) % 26) + CH_DN
				end

				res += n.chr
			end

			return res
		end

		def Cipher.rot_dec(msg, shift = 13)
			res = String.new
			msg.each_char do |ch|
				n = ch.ord

				if n.between? CH_UP, (CH_UP + 25)
					n = (((n - CH_UP) - shift) % 26) + CH_UP
				elsif n.between? CH_DN, (CH_DN + 25)
					n = (((n - CH_DN) - shift) % 26) + CH_DN
				end

				res += n.chr
			end

			return res
		end

		def Cipher.vigenere_enc(msg, key)
			res = String.new
			table = key.upcase.each_byte.map {|c| c.ord - CH_UP}

			idx = -1;
			msg.each_char do |ch|
				n = ch.ord

				if n.between? CH_UP, (CH_UP + 25)
					k = table[(idx += 1) % table.length]
					n = CH_UP + ((k + (n - CH_UP)) % 26)

				elsif n.between? CH_DN, (CH_DN + 25)
					k = table[(idx += 1) % table.length]
					n = CH_DN + ((k + (n - CH_DN)) % 26)
				end

				res += n.chr
			end

			return res
		end

		def Cipher.vigenere_dec(msg, key)
			res = String.new
			table = key.upcase.each_byte.map {|c| c.ord - CH_UP}

			idx = -1;
			msg.each_char do |ch|
				n = ch.ord

				if n.between? CH_UP, (CH_UP + 25)
					k = table[(idx += 1) % table.length]
					n = CH_UP + (((n - CH_UP) - k) % 26)

				elsif n.between? CH_DN, (CH_DN + 25)
					k = table[(idx += 1) % table.length]
					n = CH_DN + (((n - CH_DN) - k) % 26)
				end

				res += n.chr
			end

			return res
		end

		def Cipher.xor_enc(msg, key)
			raise "The maximum key size is 16 bits." if key > ((1 << 16) - 1)
			res = String.new

			bytes = msg.unpack("S*")
			bytes.each do |b|
				buffer = (b ^ key)
				res += (buffer & 0xff).chr
				res += (buffer >> 8).chr
			end

			if msg.length % 2 != 0
				res += (bytes.last & 0xff).chr
			end

			return res
		end

		def Cipher.xor_dec(msg, key)
			raise "The maximum key size is 16 bits." if key > ((1 << 16) - 1)
			res = String.new

			bytes = msg.unpack("S*")
			bytes.each do |b|
				buffer = (b ^ key)
				res += (buffer & 0xff).chr
				res += (buffer >> 8).chr
			end

			if msg.length % 2 != 0
				res += (bytes.last & 0xff).chr
			end

			return res
		end

		private_constant :CH_UP, :CH_DN
	end
end
