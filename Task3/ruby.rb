print "Enter the string of numbers with ' ' separator: "
input = gets.chomp

separators = [-1]
input.chars.each_with_index do |char, i|
    separators << i if char == ' '
end
separators << input.length

numbers = []
(0...separators.size - 1).each do |i|
    numbers << []
    (separators[i] + 1...separators[i + 1]).each do |k|
        numbers[i] << input[k]
    end
end

answer = []
(0...numbers.size).each do |i|
    summ, multi = 0, 1
    numbers[i].each do |j|
        num = j.ord - '0'.ord
        if num < 0 || num > 9
            puts "You should have entered the numbers!"
            exit
        end
        summ += num
        multi *= num
    end
    answer << i if summ < multi
end

puts answer.join(' ')
puts if answer.any?
