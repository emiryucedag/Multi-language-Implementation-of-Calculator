Interpreter Calculator - Multi-language Implementation
=================================================

This repository contains a simple arithmetic expression calculator implemented in five different programming languages:
Rust, Ada, Perl, Scheme, and Prolog. Each implementation supports basic arithmetic operations, handles input parsing, and performs error checks.

---

Rust
----
File: rust/main.rs

Description:
A Rust calculator using the `meval` crate to safely evaluate expressions entered by the user. Includes error handling and support for parentheses and exponentiation (`^`, `**`).

Run Instructions:
1. Ensure Rust is installed: https://www.rust-lang.org/tools/install
2. Navigate to the `rust` folder.
3. Run the following:
   ```bash
   cargo run
   ```

---

Ada
---
File: ada/calculator.adb

Description:
An interactive Ada-based calculator that manually parses arithmetic expressions character-by-character. It evaluates the result step by step and includes division-by-zero handling.

Run Instructions:
1. Install GNAT (Ada compiler): https://www.adacore.com/download
2. Navigate to the `ada` folder.  (cd ada)
3. Run:
   ```bash
   gnat make calculator.adb
   ./calculator
   ```

---

Perl
----
File: perl/calculator.pl

Description:
A Perl calculator that takes an arithmetic expression from the user and uses `eval` for evaluation. Includes validation to restrict accepted characters and prevent unsafe evaluation.

Run Instructions:
1. Make sure Perl is installed.
2. Run the script:
   ```bash
   perl calculator.pl
   ```

---

Scheme
------
File: scheme/calculator.scm

Description:
A simple Scheme calculator written in Racket. It accepts arithmetic expressions, validates the input, replaces `^` with `expt`, and evaluates the expression safely.

Run Instructions:
1. Install Racket: https://racket-lang.org/
2. Run the program using the Racket interpreter:
   ```bash
   racket calculator.scm
   ```

---

Prolog
------
File: prolog/calculator.pl

Description:
A minimal Prolog calculator that reads an arithmetic expression and evaluates it using the built-in arithmetic capabilities of SWI-Prolog. Handles invalid expressions gracefully.

Run Instructions (Using Online Compiler):
1. Go to: https://swish.swi-prolog.org/
2. Paste the contents of `calculator.pl` into the editor.
3. In the query box (`?-`) below, type:
   ```prolog
   calculator.
   ```
4. Run the query and enter your expression when prompted.

---

Each implementation ensures basic functionality and input validation while showcasing syntax and semantics across multiple languages.