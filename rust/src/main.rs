use std::io::{self, Write};
use meval::eval_str;

fn main() {
    println!("Simple Rust Calculator (supports + - * / ^ )");
    println!("Enter expressions like: 3 + 4 * (2 - 1)");
    println!("Type 'exit' to quit.\n");

    loop {
        print!("> ");
        io::stdout().flush().unwrap();

        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        let trimmed = input.trim();

        if trimmed.eq_ignore_ascii_case("exit") {
            break;
        }

        // Üs alma için ** → ^ çevir
        let expr = trimmed.replace("**", "^");

        match eval_str(&expr) {
            Ok(result) => println!("= {}", result),
            Err(e) => println!("Syntax error: {}", e),
        }
    }
}
