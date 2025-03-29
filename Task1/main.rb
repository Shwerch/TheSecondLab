def main
    num = gets.to_i
    
    (1..num).each do |i|
      line = ''
      (1..i).each do |j|
        char = (num - j + 'A'.ord).chr
        line += "#{char} "
      end
      puts line.strip
    end
  end
  
main