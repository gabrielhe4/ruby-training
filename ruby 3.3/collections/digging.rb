# The dig method, which is defined for Array, Hash, and Struct, allows you to “dig” through a complicated data structure in a single command.

data = {
  mcu: [
    { name: "Iron Man", year: 2010, actors: ["Robert Downey Jr.", "Gwyneth Poltrow"]}
  ],
  starwars: [
    { name: "A new Hope", year: 1977, actors: ["Mark Hammill", "Carrie Fisher"]}
  ]
}
data[:mcu][0][:actors][1] # => "Gwyneth Poltrow"
puts data.dig(:mcu, 0, :actors, 1)  # => "Gwyneth Poltrow"

# The biggest advantage of using dig is that if an element isn’t in the data structure, the method returns nil and doesn’t raise an exception.
# 