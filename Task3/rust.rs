use std::io;

fn main() {
    let mut input = String::new();
    println!("Enter the string of numbers with ' ' separator: ");
    io::stdin().read_line(&mut input).unwrap();
    
    let input = input.trim();
    
    let mut separators = vec![-1];
    for (i, char) in input.chars().enumerate() {
        if char == ' ' {
            separators.push(i as isize);
        }
    }
    separators.push(input.len() as isize);
    
    let mut numbers: Vec<Vec<char>> = Vec::new();
    
    for i in 0..(separators.len() - 1) {
        let mut number_segment: Vec<char> = Vec::new();
        
        for k in (separators[i] + 1)..(separators[i + 1]) {
            number_segment.push(input.chars().nth(k as usize).unwrap());
        }
        
        numbers.push(number_segment);
    }

    let mut answer: Vec<usize> = Vec::new();
    
    for (i, number) in numbers.iter().enumerate() {
        let mut summ = 0;
        let mut multi = 1;
        
        for &j in number.iter() {
            let num: usize = (j as usize) - ('0' as usize);
            
            if num > 9 { // Check if it's not a digit.
                println!("You should have entered the numbers!");
                return;
            }
            
            summ += num;
            multi *= num;
        }

        if summ < multi {
            answer.push(i);
        }
    }

    for &i in &answer {
        print!("{} ", i);
    }

    if !answer.is_empty() { 
       println!(); 
   }
}
