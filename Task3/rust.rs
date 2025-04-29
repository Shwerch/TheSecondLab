use std::io;

fn enter_positive_number() -> i32 {
    loop {
        let mut input = String::new();
        io::stdin()
            .read_line(&mut input)
            .expect("Failed to read line");

        let number: i32 = input.trim().parse().expect("Please type a number!");

        if number < 1 {
            println!("The number must be positive!");
        } else {
            return number;
        }
    }
}

fn enter_correct_numbers(count: i32) -> Vec<i32> {
    let mut correct_numbers = Vec::new();

    for i in 0..count {
        let mut summ = 0;
        let mut multi = 1;

        let mut number = enter_positive_number();

        while number > 0 {
            let digit = number % 10;
            summ += digit;
            multi *= digit;
            number /= 10;
        }

        if summ < multi {
            correct_numbers.push(i);
        }
    }

    correct_numbers
}

fn main() {
    println!("Enter the positive number of numbers to be entered:");

    let count = enter_positive_number();

    println!("Enter numbers greater than zero:");

    let correct_numbers = enter_correct_numbers(count);

    println!();

    if !correct_numbers.is_empty() {
        for num in &correct_numbers {
            print!("{} ", num);
        }
    } else {
        println!("There are no numbers that match the condition");
    }

    println!();
}
