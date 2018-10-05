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

class Fixnum

	def to_h
		return self.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
	end

	def degrees
		self * (180 / Math::PI)
	end

	def radians
		self * (Math::PI / 180)
	end

	def alphabet

		index = String.new
		dividend = self
		modulo = 0

		while dividend > 0
			modulo = (dividend - 1) % 26
			index = (65 + modulo).chr + index
			dividend = (dividend - modulo) / 26
		end

		return index
	end
end

class Float

	def to_r

		return "0" if self == 0

		n = 0.0
		while n < 1e4
			n += 1
			d = 0.0

			begin
				d += 1
				return "#{n.to_i}/#{d.to_i}" if (n / d) == self
			end until ((n / d) < self)
		end

		return "?/?"
	end

	def round_next(nearest)

		return (self.round / nearest) * nearest;
	end

	def degrees
		self * (180 / Math::PI)
	end

	def radians
		self * (Math::PI / 180)
	end
end
