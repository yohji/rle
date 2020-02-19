#!/usr/bin/ruby

require "test/unit"
load "lib/rle/hash.rb"

class HashcodeTest < Test::Unit::TestCase
	include Hashcode

	def test_murmur3_32
		assert_equal(0x087fcd5c, Hashcode.murmur3_32(""))
		assert_equal(0x8ee776ee, Hashcode.murmur3_32("Z"))
		assert_equal(0x890ca77b, Hashcode.murmur3_32("!?"))
		assert_equal(0xe8daf3dd, Hashcode.murmur3_32("[|]"))
		assert_equal(0x1b12f10d, Hashcode.murmur3_32("ABCD"))
		assert_equal(0x8430f6fe, Hashcode.murmur3_32("yohji"))
	end
end
