#!/usr/bin/ruby

require "test/unit"
load "lib/rle/cipher.rb"

TEXT=" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}"

class CipherTest < Test::Unit::TestCase

	def test_rot
		(1 .. 26).each do |shift|

			secret = Rle::Cipher.rot_enc(TEXT, shift)
			plain = Rle::Cipher.rot_dec(secret, shift)

			assert_equal(TEXT.size, plain.size)
			assert_equal(TEXT, plain)
		end
	end

	def test_vigenere
		charset = Array('A'..'Z') + Array('a'..'z')

		(1 .. 52).each do |i|
			key = Array.new(i) { charset.sample }.join
			secret = Rle::Cipher.vigenere_enc(TEXT, key)
			plain = Rle::Cipher.vigenere_dec(secret, key)

			assert_equal(TEXT.size, plain.size)
			assert_equal(TEXT, plain)
		end
	end

	def test_xor
		m = (1 << 16) - 1

		10000.times do |i|
			key = rand m

			secret = Rle::Cipher.xor_enc(TEXT, key)
			plain = Rle::Cipher.xor_dec(secret, key)

			assert_equal(TEXT.size, plain.size)
			assert_equal(TEXT, plain, "key: #{key}")
		end
	end
end
