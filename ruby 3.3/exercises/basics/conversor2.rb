require_relative "./temp_utils"

temps = {
  "celsius" => 1,
  "kelvin" => 2,
  "fahrenheit" => 3
}

puts "====> TEMP CONVERSOR <====="

temps.each do |key, value|
  puts "#{value}. #{key}"
end

# puts temps.key(1)
# puts temps["celsius"]

puts "Enter your choice (1 - 3): "
choice = gets.chomp.to_i

puts "#{temps.key(choice)} to: "
temps.each do |key, value|
  next if value == choice
  puts "#{value}. #{key}"
end

puts "Enter the 2nd option: "
second_choice = gets.chomp.to_i

if choice == second_choice
  puts "Cannot convert to same temp, exiting ..."
  exit
end

option = choice.to_s + second_choice.to_s

case option
  when "12"
    puts "Enter the temperature in #{temps.key(choice)}: "
    celsius = gets.chomp.to_f
    kelvin = TempUtilities.celsius_to_kelvin(celsius)
    puts "#{celsius}°C is #{kelvin}°K"
  when "13"
  when "21"
  when "23"
  when "31"
  when "32"
end

