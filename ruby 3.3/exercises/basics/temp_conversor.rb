require_relative "./temp_utils"

puts "===> Temp conversor <======"
puts "Celsius, Fahrenheit and Kelvin"
puts "1. Celsius to Fahrenheit"
puts "2. Celsius to Kelvin"
puts "3. Fahrenheit to Celsius"
puts "4. Fahrenheit to Kelvin"
puts "5. Kelvin to Celsius"
puts "6. Kelvin to Fahrenheit"
puts "7. Exit"
puts "Enter your choice: "
choice = gets.chomp.to_i

case choice
  when 1
    puts "Enter the temperature in Celsius: "
    celsius = gets.chomp.to_f
    fahrenheit = TempUtilities.celsius_to_fahrenheit(celsius)
    puts "#{celsius}°C is #{fahrenheit}°F"
  when 2
    puts "Enter the temperature in Celsius: "
    celsius = gets.chomp.to_f
    kelvin = TempUtilities.celsius_to_kelvin(celsius)
    puts "#{celsius}°C is #{kelvin}°K"
  when 3
    puts "Enter the temperature in Fahrenheit: "
    fahrenheit = gets.chomp.to_f
    celsius = TempUtilities.fahrenheit_to_celsius(fahrenheit)
    puts "#{fahrenheit}°F is #{celsius}°C"
  when 4
    puts "Enter the temperature in Fahrenheit: "
    fahrenheit = gets.chomp.to_f
    kelvin = TempUtilities.ahrenheit_to_kelvin(fahrenheit)
    puts "#{fahrenheit}°F is #{kelvin}°K"
  when 5
    puts "Enter the temperature in Kelvin: "
    kelvin = gets.chomp.to_f
    celsius = TempUtilities.kelvin_to_celsius(kelvin)
    puts "#{kelvin}°K is #{celsius}°C"
  when 6
    puts "Enter the temperature in Kelvin: "
    kelvin = gets.chomp.to_f
    fahrenheit = TempUtilities.kelvin_to_fahrenheit(kelvin)
    puts "#{kelvin}°K is #{fahrenheit}°F"
  else
    puts "Invalid option"
    exit
end