require_relative './password_option.rb'

lowercase = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y','z']
uppercase = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y','Z']
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
symbols = ['!','.','?','@','$']
options = []

puts "Add lower case letters? (yes/no)"
input = gets.chomp.to_s
if input.downcase == 'yes'
  option = PasswordOption.new("lowercase", lowercase)
  options << option
end

puts "Add upper case letters? (yes/no)"
input = gets.chomp.to_s
if input.downcase == 'yes'
  option = PasswordOption.new("uppercase", uppercase)
  options << option
end

puts "Add numbers? (yes/no)"
input = gets.chop.to_s
if input.downcase == 'yes'
  option = PasswordOption.new("numbers", numbers)
  options << option
end

puts "Add symbols?"
input = gets.chop.to_s
if input.downcase == 'yes'
  option = PasswordOption.new("symbols", symbols)
  options << option
end

for option in options do 
  puts "#{option.name} "
end