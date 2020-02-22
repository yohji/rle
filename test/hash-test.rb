#!/usr/bin/ruby

require "test/unit"
load "lib/rle/hash.rb"

class HashcodeTest < Test::Unit::TestCase

	def test_murmur3_32
		assert_equal(0x087fcd5c, Rle::Hashcode.murmur3_32(""))
		assert_equal(0x8ee776ee, Rle::Hashcode.murmur3_32("Z"))
		assert_equal(0x890ca77b, Rle::Hashcode.murmur3_32("!?"))
		assert_equal(0xe8daf3dd, Rle::Hashcode.murmur3_32("[|]"))
		assert_equal(0x1b12f10d, Rle::Hashcode.murmur3_32("ABCD"))
		assert_equal(0x8430f6fe, Rle::Hashcode.murmur3_32("yohji"))
	end
end
