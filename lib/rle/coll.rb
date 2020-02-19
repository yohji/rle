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

class Array

	def avg
		return self.inject(0.0) {|sum, el| sum + el} / self.size
	end
end

class MultiHash < Hash

	alias :[]= :store

	def initialize
		@size = 0
	end

	def store(key, value)

		values = self[key]
		if values.nil?
			self[key] = (values = Array.new)
		end

		values.push value
		@size += 1
	end

	def values

		values = Array.new
		keys.each do |k|
			self[k].each do |v|
				values.push v
			end
		end

		return values
	end

	def values_at(*keys)

		values = Array.new
		keys.each do |k|
			if self.keys.include? k
				self[k].each do |v|
					values.push v
				end
			end
		end

		return values
	end

	def delete_value(key, value)

		if has_key? key
			self[key].delete value
			@size -= 1
			self.delete key if self[key].empty?
		end
	end

	def size
		@size
	end

	def value?(value)

		keys.each do |k|
			self[k].each do |v|
				if v == value
					return true
				end
			end
		end

		return false
	end
end
