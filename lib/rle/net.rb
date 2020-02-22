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

require 'net/http'

module Rle
	module Web

		def Web.http_get url
			uri = URI(url)

			res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
				req = Net::HTTP::Get.new(uri)
				yield req if block_given?
				http.request(req)
			end
			return res
		end

		def Web.http_post url
			uri = URI(url)

			res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
				req = Net::HTTP::Post.new(uri)
				yield req if block_given?
				http.request(req)
			end
			return res
		end
	end
end
