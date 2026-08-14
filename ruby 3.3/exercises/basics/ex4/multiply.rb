=begin
Tabla de multiplicar

    Pide un número al usuario.
    Muestra su tabla de multiplicar del 1 al 10.
    Extra: permite elegir el rango de la tabla (ej. del 5 al 15).
=end

puts "Multiplication table ==>"
puts "Which number whants your table?"
number = gets.chomp.to_i
puts "Choose the range of the table from:"
from_range = gets.chomp.to_i
puts "to: "
to_range = gets.chomp.to_i



if (from_range < 1)
  puts "The range must be greater than 0."
  exit
end

if(to_range < 2 and to_range > from_range) 
  puts "The range must be greater than 1."
  exit
end

for i in from_range..to_range do
  puts "#{number} x #{i} = #{number*i}"
end