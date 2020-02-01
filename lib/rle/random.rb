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

def rand_hex length
	require 'securerandom'
	SecureRandom.hex (length / 2)
end

def rand_pwd length
	charset = Array('A'..'Z') + Array('a'..'~') + Array('!'..'*') + Array('?'..'~')
	charset.delete "\""; charset.delete "\\";
	Array.new(length) { charset.sample }.join
end

def rand_pat length, size = 4
	pat = String.new
	length.times do |l|
		size.times do |s|
			pat << (65 + (l % 26)).chr
		end
	end
	return pat
end
