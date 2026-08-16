class PasswordGenerator
  
    def initialize(max_length)
      @max_length = max_length
      @password = ""
      @allowed_symbols = ['!','.','?','@','$']
      @allowed_numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      @allowed_uppercase = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y','Z']
      @allowed_lowercase = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y','z']
    end

    def get_random_symbol()
      index = rand(0..@allowed_symbols.length - 1)
      return @allowed_symbols[index]
    end

    def get_random_number()
      index = rand(0..@allowed_numbers.length - 1)
      return @allowed_numbers[index].to_s
    end

    def get_random_uppercase()
      index = rand(0..@allowed_uppercase.length - 1)
      return @allowed_uppercase[index]
    end

    def get_random_lowercase()
      index = rand(0..@allowed_lowercase.length - 1)
      return @allowed_lowercase[index]
    end

    def generate_password()
      @password << get_random_uppercase()
      @password << get_random_lowercase()
      @password << get_random_number()
      @password << get_random_symbol()
      rest_pass = @max_length - 4

      rest_pass.times do
        option = rand(1..4)
        case option
          when 1 then @password << get_random_uppercase()
          when 2 then @password << get_random_lowercase()
          when 3 then @password << get_random_number()
          when 4 then @password << get_random_symbol()
        end
      end

      return @password
    end

    private :get_random_symbol, :get_random_number, :get_random_uppercase, :get_random_lowercase
end