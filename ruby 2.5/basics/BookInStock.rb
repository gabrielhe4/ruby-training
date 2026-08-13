class BookInStock
  
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def isbn
    @isbn
  end

  def price
    @price
  end

  def to_s
    "ISBN: #{@isbn}, price: #{@price}"
  end

end

a_book = BookInStock.new("isbn1", 3)
p a_book
puts "ISBN = #{a_book.isbn}"
puts "Price: #{a_book.price}"