class Task
  attr_accessor :title, :status, :id

  def initialize(id, title)
    @title = title
    @status = false
    @id = id
  end

  def update_status(status)
    @status = status
  end

end