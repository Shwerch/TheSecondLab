use std::io;

fn main() {
    let mut input = String::new();
    println!("Enter the string of numbers with ',' separator: ");
    io::stdin().read_line(&mut input).unwrap();
    let input = input.trim();

    let mut separators = vec![-1];
    for (i, char) in input.chars().enumerate() {
        if char == ',' {
            separators.push(i as isize);
        }
    }
    separators.push(input.len() as isize);

    let mut count = 0;
    for i in 0..(separators.len() - 1) {
        count += (separators[i + 1] - separators[i] - 1) % 2;
        for j in (separators[i] + 1)..(separators[i + 1]) {
            let char = input.chars().nth(j as usize).unwrap();
            if !char.is_digit(10) {
                println!("You should have entered the numbers!");
                return;
            }
        }
    }
    println!("{}", count);
}
