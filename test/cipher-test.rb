#!/usr/bin/ruby

require "test/unit"
load "lib/rle/cipher.rb"

# TEXT="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}:\"|<>/\\"
TEXT="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

class CipherTest < Test::Unit::TestCase

	def test_rot
		(1 .. 26).each do |shift|

			secret = Cipher.rot_enc(TEXT, shift)
			plain = Cipher.rot_dec(secret, shift)

			assert_equal(TEXT, plain)
		end
	end

	def test_vigenere
		charset = Array('A'..'Z') + Array('a'..'z')

		(1 .. 52).each do |i|
			key = Array.new(i) { charset.sample }.join
			secret = Cipher.vigenere_enc(TEXT, key)
			plain = Cipher.vigenere_dec(secret, key)

			assert_equal(TEXT, plain)
		end
	end

	def test_xor
		(1 .. 9999).each do |key|

			secret = Cipher.xor_enc(TEXT, key)
			plain = Cipher.xor_dec(secret, key)

			assert_equal(TEXT.size, plain.size)
			assert_equal(TEXT, plain, "key: #{key}")
		end
	end
end
