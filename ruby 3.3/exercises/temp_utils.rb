class TempUtilities
  def self.kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end

  def self.kelvin_to_fahrenheit(kelvin)
    (kelvin * 9/5) - 459.67
  end

  def self.celsius_to_fahrenheit(celsius)
    (celsius * 9/5) + 32
  end

  def self.celsius_to_kelvin(celsius)
    celsius + 273.15
  end

  def self.fahrenheit_to_celsius(fahrenheit)
    (fahrenheit - 32) * 5/9
  end

  def self.fahrenheit_to_kelvin(fahrenheit)
    (fahrenheit + 459.67) * 5/9
  end
end