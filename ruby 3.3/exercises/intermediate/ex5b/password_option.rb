class PasswordOption
  
  # attr_accessor :name, :characters
  attr_reader :name, :characters

  def initialize(name, characters)
    @name = name
    @characters = characters
  end

end