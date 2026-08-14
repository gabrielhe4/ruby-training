require_relative './task.rb'
require_relative './list_task.rb'

def start_menu()
  puts "-- MAIN MENU ---"
  puts "1. Add new task"
  puts "2. Delete task"
  puts "3. Mark as complete"
  puts "4. View all tasks"
  puts "5. Exit"
end

def select_from_menu(choice_option, list)
  
  case choice_option
    when 1
      puts "Enter task name:"
      title = gets.chomp.to_s
      list.add_task(title)
    when 2
      puts "Enter task ID to delete:"
      id_to_delete = gets.chomp.to_i
      list.delete_task(id_to_delete)
    when 3
      puts "Enter task ID to mark as complete:"
      id_to_complete = gets.chomp.to_i
      list.update_task(id_to_complete, true)
    when 4
      puts " ====> Listing all the current tasks: "
      list.show_tasks()
      puts " ====> End of listing all the current tasks. "
    when 5
      exit
    else
      puts "Invalid option. Please try again."
  end

end

def main_loop()
  list = ListTask.new()
  while true do
    start_menu()
    puts "Select an option: "
    choice = gets.chomp.to_i
    select_from_menu(choice, list)
  end
end

main_loop() # list is an instance of ListTask

