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

def rand_alphanum(number)
	charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
	Array.new(number) { charset.sample }.join
end