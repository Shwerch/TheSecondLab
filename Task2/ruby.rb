print "Enter the string of numbers with ',' separator: "
input = gets.chomp

separators = [-1]
input.chars.each_with_index do |char, i|
    separators << i if char == ','
end
separators << input.length

count = 0
(0...separators.size - 1).each do |i|
    count += (separators[i + 1] - separators[i] - 1) % 2
    (separators[i] + 1...separators[i + 1]).each do |j|
        if input[j] < '0' || input[j] > '9'
            puts "You should have entered the numbers!"
            exit
        end
    end
end
puts count
