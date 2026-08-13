class BookInStock
  attr_reader :isbn, :price     # getters
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price=(new_price)
    @price = new_price
  end
end


book = BookInStock.new("isbn1", 3.0)
puts book.isbn
puts book.price

=begin
There’s a common misconception that the attr_reader declaration actually declares instance variables. 
It doesn’t. It creates the accessor methods, but the variables themselves don’t need to be declared. 
An instance variable pops into existence when you assign a value to it, 
and any instance value that hasn’t been assigned a value returns nil
=end


=begin
class JavaBookInStock {
  private double _price;
  
  private double getPrice() {
    return _price;
  }

  void setPrice(double newPrice) {
    _price = newPrice;
  }
}
=end