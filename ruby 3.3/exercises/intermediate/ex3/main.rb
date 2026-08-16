require_relative './phonebook.rb'

def show_menu()
  puts "1. Add contact"
  puts "2. Find contact"
  puts "3. Delete contact"
  puts "4. View contacts"
  puts "5. Exit"
end

def add_contact(phonebook)
  puts "Enter name:"
  name = gets.chomp.to_s
  puts "Enter phone number:"
  number = gets.chomp.to_s
  phonebook.add_contact(name, number)
end

def find_contact(phonebook)
  puts "Enter name to find:"
  name_to_find = gets.chomp.to_s
  contact = phonebook.find_contact(name_to_find)
  if contact
    puts "👉 Contact found: #{contact}"
  else
    puts "Not found"
  end
end

def select_option(choice, phonebook)
  case choice
    when 1
      add_contact(phonebook)
    when 2
      find_contact(phonebook)
    when 3
      puts "Enter name to delete:"
      name_to_delete = gets.chomp.to_s
      phonebook.delete_contact(name_to_delete)
    when 4
      puts "Contacts:"
      phonebook.view_contacts()
      puts "--> End of contacts."
    when 5
       exit
    else
      puts "Invalid option. Please try again"
  end
      
end

phonebook = Phonebook.new()
while true do
  show_menu()
  choice = gets.chomp.to_i
  select_option(choice, phonebook)
end