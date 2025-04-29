def enter_positive_number
  loop do
    number = gets.to_i
    if number < 1
      puts "The number must be positive!"
    else
      return number
    end
  end
end

def enter_correct_numbers(count)
  correct_numbers = []

  count.times do |i|
    summ, multi = 0, 1
    number = enter_positive_number

    while number > 0 do
      digit = number % 10
      summ += digit
      multi *= digit
      number /= 10
    end

    correct_numbers << i if summ < multi
  end

  correct_numbers
end

puts "Enter the positive number of numbers to be entered: "
count = enter_positive_number
puts "Enter numbers greater than zero: "
correct_numbers = enter_correct_numbers(count)
puts

if !correct_numbers.empty?
  puts correct_numbers.join(' ')
else
  puts "There are no numbers that match the condition"
end
