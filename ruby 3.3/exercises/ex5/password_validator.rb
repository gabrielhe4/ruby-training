=begin
Validador de contraseñas

    Pide al usuario crear una contraseña.
    Verifica que tenga al menos 8 caracteres, una mayúscula, una minúscula y un número.
    Muestra un mensaje indicando qué criterios cumple y cuáles no.

=end

puts "Pick a password"
password = gets.chomp.to_s

if password.length < 8
   puts "Password must be at least 8 characters long."
end

if not password.match?(/[a-z]/)
  puts "Password must contain lowercase letters."
end

if not password.match?(/[A-Z]/)
  puts "Password must contain an uppercase letter."
end

if not password.match?(/[0-9]/)
  puts "Password must contain a number."
end


