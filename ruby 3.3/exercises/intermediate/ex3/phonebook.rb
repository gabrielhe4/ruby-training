class Phonebook
  
  def initialize
    @phonebook = Hash.new
  end

  def add_contact(contact_name, phone_number)

    if !phone_number.match?(/\d{3}-\d{3}-\d{4}/)
      puts "❌ Invalid phone number format. Please use the format: XXX-XXX-XXXX"
    else 
      @phonebook.store(contact_name, phone_number)
      puts "✅ A new contact was created."
    end
    
  end

  def find_contact(contact_name)
    #return nil unless hash.has_key?(contact_name)
    if @phonebook.has_key?(contact_name)
      @phonebook.fetch(contact_name)
    else 
      puts "👎 Contact not found"
    end
  end

  def delete_contact(contact_name)
    
    if @phonebook.has_key?(contact_name)
      @phonebook.delete(contact_name)
      puts "✅ A contact was deleted."
    else 
      puts "👎 Contact not found"
    end
      
  end

  def view_contacts()
    @phonebook.each do |name, number|
      puts "#{name}: #{number}"
    end
  end
end