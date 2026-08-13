def calculate_tip(total_check, tip_percentage)
    tip_amount = total_check * (tip_percentage / 100)
    return tip_amount
end


puts "Total check is: $123.45 dls"
total_check = 123.45
puts "you can tip what you want, but it should be less than 20%"
puts "How much do you want to tip? "
tip_percentage  = gets.chomp.to_f

if tip_percentage < 0
    puts "You cannot tip a negative amount"
    exit
else 
  puts "#{tip_percentage}%, that's great! Thank you!"
end

total_tip = calculate_tip(total_check, tip_percentage)
puts "Tip amount: $#{total_tip} dls"
puts "Check without tip: #{total_check} dls"
total_check = total_check + total_tip

puts "Your total check is: $#{total_check} dls"