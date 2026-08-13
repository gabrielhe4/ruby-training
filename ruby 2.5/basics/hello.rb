# Different version of print function in Ruby

puts "Some arguments ====> #{ARGV.size}"

puts("Hello world!!!")

print "Hello Again!!!"

p "I'm learning Ruby!"

puts "My name is: Kathy \n\nand I'm psychologist student"

age_in_days = 365 * 34

age_in_hours = 24 * 365 * 34

age_in_minutes = 60 * 24 * 365 * 34

p "----> Starting with some exercises <------- "

puts "My age in days is: #{age_in_days} days"

puts "My age in hours is: #{age_in_hours} hours"

puts "My age in minutes is: #{age_in_minutes} minutes"

p "Introduce a new value: "
#obtain_value = gets

puts "gin joint".length()
puts "Rick".index("c")
puts 42.even?
puts 43.odd?

num = -1234
positive = num.abs()
puts positive

# Methods basic definition
# 

# this implicity calls the return value
def say_hello(name)
  "I don't know why you say goodbye, #{name}, I say hello"
  # return
end

notes = <<~TEXT
---->
This version is considered more idiomatic, 
by which we mean that it’s more in line with how expert 
Ruby programmers have chosen to write Ruby programs
TEXT

salute = say_hello("Gab")
puts salute
puts notes

# arrays

a = [1, 'cat', 3.14]
puts a[0] # first element

a[2] = nil  # => nil is an object that represents the concept of nothing
puts "The array is now #{a.inspect()}"

# hash
# 

instrument_section = {
  "cello" => "string",
  "clarinet" => "woodwind",
  "drum" => "percussion",
  "oboe" => "woodwind",
  "trumpet" => "brass",
  "violin" => "string"
}

puts instrument_section["oboe"]

# Sometimes you’ll want to change this default behavior. 
# For example, if you’re using a hash to count the number 
# of times each different word occurs in a file
# Then you can use the word as the key and increment the corresponding 
# hash value without worrying about whether you’ve seen that word before. 
# This can be done by specifying a default value when you create a new, empty hash:

histogram = Hash.new(0) # the default value is zero
histogram["ruby"] # => 0
histogram["ruby"] = histogram["ruby"] + 1
histogram["ruby"] # => 1

puts "The histogram is now #{histogram.inspect()}"

# SYMBOLS
#  Ruby’s symbols. Symbols aren’t exactly optimized strings, 
#  but for most purposes, you can think of them as special strings that are immutable, 
#  are only created once, and are fast to look up. 
#  Symbols are meant to be used as keys and identifiers, 
#  while strings are meant to be used for data.
#  
# A symbol literal starts with a colon and is followed by some kind of name:
# walk(:north)
# look(:east)
# 

def walk(direction)
  if direction == :north
    puts "You're walking north."
  elsif direction == :south
    puts "You're walking south."
  else
    puts "I don't know how to #{direction}."
  end
end

walk(:north)

# Because their values don’t change, symbols are frequently used as keys in hashes

instrument_section_2 = {
  :cello => "string",
  :clarinet => "woodwind",
  :drum => "percussion",
  :oboe => "woodwind",
  :trumpet => "brass",
  :violin => "string"
}

puts instrument_section_2[:cello]
puts instrument_section_2[:oboe]
instrument_section_2["cello"] # => nil

# Symbols are so frequently used as hash keys that Ruby has a shortcut syntax. 
# You can use name: value pairs to create a hash instead of name => value if the key is a symbol:
# 

instrument_section_3 = {
  cello: "string",
  clarinet: "woodwind",
  drum: "percussion",
  oboe: "woodwind",
  trumpet: "brass",
  violin: "string"
}

puts "An oboe is a #{instrument_section_3[:oboe]} instrument"

# This syntax was added, in part, for programmers familiar with JavaScript and Python, 
# both of which use a colon as a separator in key/value pairs.
# 

## Control Structures
#
today = Time.now()
puts "Today is #{today}"

if today.saturday?
  puts "It's Saturday!"
elsif today.monday?
  puts "It's Monday!"
else
  puts "It's neither Monday nor Saturday."
end


# while
# 

#num_pallets = 0
#weight = 0
#while weight < 100 && num_pallets <= 5
#  pallet = next_pallet()
#  weight += pallet.weight
#  num_pallets += 1
#end

# puts "Danger, Will Robinson" if radiation > 3000
square = 4
while square < 1000
  square *= square
  puts square
end
#square = square * square while square < 1000
#puts square

# REGULAR EXPRESSIONS
# /Ruby|Rust/
# /Ru(by|st)/

pattern = /\d\d:\d\d:\d\d/  # a time such as 12:34:56
pattern_1 = "/Ruby.*Rust/"  # Ruby, zero or more other chars, then Rust
pattern_2 = "/Ruby Rust/"   # Ruby, exatky one space, and Rust
pattern_3 = "/Ruby *Rust/"  # Ruby, zero or more spaces, and Rust

puts pattern.match("12:34:56") 

line = gets
if line.match?(/Ruby|Rust/)
  puts "Scripting language mentioned: #{line}"

end

line = gets
newline = line.sub(/Python/, 'Ruby')
puts newline

# blocks

# Un block es código encerrado entre do...end o entre llaves {...}. 
# No es un objeto por sí mismo (a diferencia de un Proc o lambda), 
# sino que se adjunta a una llamada de método.


# Sintaxis con do/end (preferida para bloques de varias líneas)

[1,2,3].each do |num|
  puts num
end

# Sintaxis con llaves (preferida para bloques de una línea)
[1,2,3].each { |num| puts num * 2 }


# El método que recibe el block puede ejecutarlo con la palabra clave yield

def saludar
  puts "Hola"
  yield          # ejecuta el block que se pasó
  puts "Adiós"
end

saludar do
  puts "Estoy en el medio"
end

# Salida:
# Hola
# Estoy en el medio
# Adiós
# 

def call_block
  puts "Start of method"
  yield
  yield
  puts "End of method"
end

call_block { puts "in the block"}

def who_says_what
  yield("Dave", "hello")
  yield("Andy", "goodbye")
end

who_says_what { |person, greeting| puts "#{person} says #{greeting}" } 

animals = ["ant", "bee", "cat", "dog"]
animals.each { |animal| puts animal }

puts "===========>"
["cat", "dog", "horse"].each { |name| print name, " "}
5.times { print "*" }
3.upto(6) { |i| print i }
("a".."e").each {|char| print char }
("a".."e").each { print _1 }