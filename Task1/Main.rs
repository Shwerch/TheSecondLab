use std::io;

fn main() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let num: i32 = input.trim().parse().expect("Please enter a number");

    for i in 1..=num {
        for j in 1..=i {
            let ch = (num - j + 'A' as i32) as u8 as char;
            print!("{} ", ch);
        }
        println!();
    }
}