require_relative './task.rb'

class ListTask
  
  def initialize
    @tasks = []
    @id_generator = 0
  end

  def add_task(task_name) # task_name is a string
    @id_generator += 1
    new_task = Task.new(@id_generator, task_name)
    @tasks << new_task
  end

  def show_tasks()
    @tasks.each do |task|
      puts "#{task.id}. #{task.title} - #{task.status ? '✅ Completed' : '❌ Not Completed'}"
    end
  end

  def delete_task(id_task)
    if exists_by_id?(id_task)
      @tasks.delete_if { |task| task.id == id_task }
    else
      puts "❌ Error: Task with ID #{id_task} does not exist. Please try again."
    end
  end

  def update_task(id_task, new_status)

    if !exists_by_id?(id_task)
      puts "❌ Error: Task with ID #{id_task} does not exist. Please try again."
      return
    end

    @tasks.each do |task|
      if task.id == id_task
        task.update_status(new_status)
        break
      end
    end
  end

  def exists_by_id?(id_task)
    @tasks.any? { |task| task.id == id_task }
  end

  private :exists_by_id?

end