#!/usr/bin/ruby

require "test/unit"
load "lib/rle/coll.rb"

class MultiHashTest < Test::Unit::TestCase

	def setup
		@map = MultiHash.new

		@map.store(1, 11)
		@map.store(1, 12)
		@map.store(2, 21)
		@map.store(2, 22)
		@map.store(2, 23)
		@map.store(3, 31)
	end

	def test_store

		assert(@map.include?(1))
		assert_equal(3, @map.keys.size)
		assert_equal(6, @map.size)
	end

	def test_values

		assert_equal([11, 12, 21, 22, 23, 31], @map.values)
		assert_equal([21, 22, 23, 31], @map.values_at(2, 3))

		assert(@map.value?(22))
		assert(! @map.value?(34))
	end

	def test_delete

		@map.delete_value(2, 22)
		@map.delete_value(3, 31)

		assert_equal(4, @map.size)
		assert(! @map.value?(22))
		assert(! @map.value?(31))
	end
end
