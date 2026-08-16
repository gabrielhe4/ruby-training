require_relative './cesar_cipher.rb'

puts "Input the text you want to cipher: "
text = gets.chomp.to_s

puts "Enter the shift value (1-25): "
shift = gets.chomp.to_i

cesar_cipher = CesarCipher.new(text,shift)

puts "Ciphertext: #{cesar_cipher.obtain_ciphered_text()}"