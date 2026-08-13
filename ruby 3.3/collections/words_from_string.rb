def words_from_string(string)
  string.downcase.scan(/[\w']+/)
end

words = words_from_string("I like ruby, it is (usually) optimized for programmer happiness")
counts(words)
=begin
 downcase, which returns a lowercase version of a string, and scan, which returns an array of 
 substrings that match a given pattern. In this case, the pattern is [\w’]+, 
 which matches sequences containing “word characters” and single quotes.
=end