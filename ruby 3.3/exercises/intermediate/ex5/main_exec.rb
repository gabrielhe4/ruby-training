require_relative './password_generator.rb'
=begin 
Generador de contraseñas seguras

    Genera contraseñas aleatorias con longitud configurable.
    Permite elegir qué tipos de caracteres incluir (mayúsculas, minúsculas, números, símbolos).
    Asegura que al menos haya un carácter de cada tipo seleccionado.

=end
puts "====> PASSWORD GENERATOR <===="
puts "Enter the password length: "
password_length = gets.chomp.to_i

if password_length < 8 then 
  puts "Password length must be at least 8 characters."
  exit 
end

password_generator = PasswordGenerator.new(password_length)
password = password_generator.generate_password()
puts password

