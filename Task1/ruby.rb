print "Enter the N number: "
num = gets.to_i

if num < 1 || num > 26
    puts "The N number must be from 1 to 26!"
else
    (0...num).each do |i|
        (0..i).each do |j|
            print "#{(num - j - 1 + 'A'.ord).chr} "
        end
        puts
    end
end
