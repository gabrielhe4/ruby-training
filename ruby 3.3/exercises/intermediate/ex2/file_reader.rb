# https://rubyguides.dev/reference/hash-methods/
my_file = File.open("./some_file.txt", "r")

def add_word_in_hash(word, hash)
  final_word = word.downcase
  if hash.has_key?(final_word)
    next_value = hash[final_word] + 1
    hash[final_word] = next_value
  else
    hash.store(final_word, 1)
  end
end

def print_hash(hash)
  puts "Top ten most repeated words =>"
  count = 0
  hash.each do |key, value|
    puts "#{key}: #{value}"
    if count > 8
      break
    end
    count += 1
  end
end

hash_words = Hash.new

my_file.each_line do |line|
  words = line.split(" ")
  words.each do |word|
    add_word_in_hash(word, hash_words)
  end
end

hash_words = hash_words.sort_by { |key, value| value }.reverse

print_hash(hash_words)