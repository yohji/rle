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

##
# MurmurHash3 was written by Austin Appleby, and is placed in the public
# domain. The author hereby disclaims copyright to this source code.
module Murmur3

	def Murmur3.hash32(data, seed = 42)

		len = data.length
		hash = add32(seed, 0)

		blocks = data.unpack "L*"
		blocks.each do |k|

			k = mult32(k, C1)
			k = rotl32(k, R1)
			k = mult32(k, C2)

			hash ^= k
			hash = rotl32(hash, R2)
			hash = add32(mult32(hash, 5), 0xe6546b64)
		end

		k = 0
		case len & 3
		when 3 then
			tail = data.getbyte(len - 1).ord
			k ^= lshift32(tail, 16)

			tail = data.getbyte(len - 2).ord
			k ^= lshift32(tail, 8)

			k ^= data.getbyte(len - 3).ord
			k = mult32(k, C1)
			k = rotl32(k, R1)
			k = mult32(k, C2)
			hash ^= k

		when 2 then
			tail = data.getbyte(len - 1).ord
			k ^= lshift32(tail, 8)

			k ^= data.getbyte(len - 2).ord
			k = mult32(k, C1)
			k = rotl32(k, R1)
			k = mult32(k, C2)
			hash ^= k

		when 1 then
			k ^= data.getbyte(len - 1).ord
			k = mult32(k, C1)
			k = rotl32(k, R1)
			k = mult32(k, C2)
			hash ^= k
		end

		hash ^= len
		hash = fmix32(hash)

		return hash
	end

	# private

	MASK_32 = (1 << 32) - 1
	C1 = 0xcc9e2d51
	C2 = 0x1b873593
	R1 = 15
	R2 = 13

	def Murmur3.add32(m, n)
		return (m + n) & MASK_32
	end

	def Murmur3.mult32(m, n)
		return (m * n) & MASK_32
	end

	def Murmur3.rotl32(x, r)
		m = (1 << (32 - r)) - 1
		return ((x & m) << r) | (x >> (32 - r))
	end

	def Murmur3.lshift32(x, s)
		return (x << s) & MASK_32
	end

	def Murmur3.fmix32(h)
		h ^= h >> 16
		h = mult32(h, 0x85ebca6b)
		h ^= h >> 13
		h = mult32(h, 0xc2b2ae35)
		h ^= h >> 16
	end

	private_constant :MASK_32, :C1, :C2, :R1, :R2
	private_class_method :add32, :mult32, :rotl32, :lshift32, :fmix32
end
