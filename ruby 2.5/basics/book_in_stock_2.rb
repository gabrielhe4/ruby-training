class BookInStock
  attr_reader :isbn, :price     # getters
  attr_accessor :price     # setters
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  # you may want to access the price as an exact number of cents rather than as a floating-point number of dollars.
  def price_in_cents
    (price * 100).round
  end
end

book = BookInStock.new("isbn1", 3.0)
puts book.isbn
book.price = 4.5
puts book.price

puts "Price in cents: #{book.price_in_cents()}"