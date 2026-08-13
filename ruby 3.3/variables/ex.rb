person = "Tim"
puts "The object in person is a #{person.class}"
puts "The object has an id of #{person.object_id}"
puts "and a value of '#{person}'"

person2 = person
person[0] = 'J'

puts "person1: #{person}"
puts "person2: #{person2}"

# Ruby strings are mutable, unlike Java’s), but both person1 and person2 changed from Tim to Jim.
# This is because the string object itself was not modified, but rather a new string object was created with the updated value. The original string object remains unchanged.
# 
#

# You can also prevent anyone from changing a particular object by freezing it. Attempt to alter a frozen object
person.freeze