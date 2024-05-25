use std::fs::File;
use std::io::{self, Read};

const OPEN: char = '(';
const CLOSED: char = ')';

fn main() {
    // Read the file
    let mut file = File::open("input.txt").unwrap();
    let mut input = String::new();
    file.read_to_string(&mut input).unwrap();


    let mut result = 0;
    for c in input.chars() {
       if c == OPEN { result += 1; }
       if c == CLOSED { result -= 1; }
    }

    println!("{}", result);
}

