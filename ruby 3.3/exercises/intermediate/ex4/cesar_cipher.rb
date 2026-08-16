class CesarCipher
  #attr_accessor :text, :shift

  def initialize(text, shift)
    @text = text.to_s
    @shift = shift.to_i
    @array_chars = []
  end

  def is_downcase_letter?(byte)
    (byte >= 97 and byte <= 122)
  end

  def is_uppercase_letter?(byte)
    (byte >= 65 and byte <= 90)
  end

  def cipher_downcase(byte)
    if byte >= 122
      byte_difference = (byte + @shift) - 122
      return 97 + byte_difference
    else
      return byte + @shift
    end
  end

  def cipher_uppercase(byte)
    if byte >= 90
      byte_difference = (byte + @shift) - 90
      return 65 + byte_difference
    else
      return byte + @shift
    end
  end

  def cipher_text()
    @text.bytes.each do |byte|
      if is_downcase_letter?(byte)
        new_byte = cipher_downcase(byte)
        @array_chars << new_byte.chr

      elsif is_uppercase_letter?(byte)
        new_byte = cipher_uppercase(byte)
        @array_chars << new_byte.chr

      else
        @array_chars << byte.chr
      end
    end 
  end

  def obtain_ciphered_text()
    cipher_text()
    @array_chars.join()
  end

  private :cipher_downcase, :cipher_uppercase, :is_downcase_letter?, :is_uppercase_letter?, :cipher_text

end