=begin
  Pide al usuario una frase.
  Cuenta cuántas palabras, caracteres (con y sin espacios) y líneas tiene.
  Extra: identifica la palabra más larga.
=end

hash_words = Hash.new
puts "Type some phrase: "
phrase = gets.chomp.to_s

words = phrase.split(" ")
words.each do |word|
  new_word = word.gsub(/[^a-zA-Z0-9 ]/, '')
  hash_words.store(new_word.to_s, new_word.length)
end

hash_words.each do |key, value|
  puts "#{key}: #{value}"
end

puts "=====> "
longest_word, w_length =  hash_words.max_by { |key, value| value }


puts "The longest word is: '#{longest_word}' with #{w_length} characters."
