a = [3.1416, "pie", 99]
puts a.class
puts a.length

b = ["ant", "bat", "cat", "dog", "elephant", "elk"]
puts b[-2]  # prints elephant
puts b[-1,2]
puts b[1..3]
puts b[1...3]

puts "====>"
puts b[-3..-1]

# ===>
puts "====> _-_- <===="
stack = []
stack.push "red"
stack.push "green"
stack.push "blue"

puts stack

stack.pop # removes blue

queue = []

array = [1,2,3,4,5,6,7,8]
puts array.first(4)

# ===>

hash = { "dog" => "canine", "cat" => "fline", "bear" => "ursine"}

puts "Hash length: #{hash.length()}"
puts hash["dog"]
puts hash["cow"] = "bovine"

firstname = "Fred"
lastname = "Flinstone"
user = { firstname: firstname, lastname: lastname }
puts user