use std::io;

fn main() {
    let mut input = String::new();
    println!("Enter the N number: ");
    io::stdin().read_line(&mut input).unwrap();
    
    let num: usize = input.trim().parse().unwrap();

    if num < 1 || num > 26 {
        println!("The N number must be from 1 to 26!");
        return;
    }

    for i in 0..num {
        for j in 0..=i {
            print!("{} ", (num - j - 1 + 'A' as usize) as u8 as char);
        }
        println!();
    }
}
