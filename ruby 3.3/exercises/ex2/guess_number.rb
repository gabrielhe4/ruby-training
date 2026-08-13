=begin
Adivina el número

    El programa genera un número aleatorio entre 1 y 100.
    El usuario tiene intentos limitados para adivinarlo.
    Después de cada intento, indica si el número es mayor o menor.
    Al terminar, ofrece la opción de jugar de nuevo.

=end

random_number = rand(1..30)
#puts random_number
max_retries = 7
current_retries = 1

puts "Guess the number!!!"
while current_retries <= max_retries do
  puts "Retry number: #{current_retries}"  
  puts "Input your number: "
  guess_number = gets.chomp.to_i
  if random_number == guess_number
    puts "Congratulations! You guessed the number in #{current_retries} attempts."
    break
  else
    puts "Wrong number. Try again!"
  end
  current_retries += 1
end

puts "Game over! The correct number was #{random_number}."