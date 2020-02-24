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

class String

	alias :len :length

	def numeric?
		return self =~ /-?\d+([\.,]\d+)?/
	end

	def blank?
		self.strip.empty?
	end

	def to_b
		r = 0

		self.each_byte do |b|
			r <<= 8 if r != 0
			r |= b
		end

		return r
	end

	def stat(chunk = 1)
		stat = Hash.new

		idx = 0
		buf = String.new if chunk != 1
		self.each_char do |ch|

			if chunk == 1
				k = ch.upcase
				stat[k] = 0 if stat[k].nil?
				stat[k] += 1
			else
				buf << ch.upcase
				if ((idx += 1) % chunk) == 0
					stat[buf] = 0 if stat[buf].nil?
					stat[buf] += 1
					buf.clear
				end
			end
		end

		return stat.sort_by { |k, v| -v }
	end
end
