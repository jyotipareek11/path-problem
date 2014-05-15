# Pather

Given a text file 'input.txt' with a rectangular block of dot
characters ('.') and exactly two hash characters ('#'), the program 'pather'
writes out to 'output.txt' the same data with the two '#' characters
joined by asterisks ('*'). The command is invoked like this:

  pather input.txt output.txt

The rules for the path:

* No diagonals.
* Only change direction once.
* Start with a vertical line and then complete with a horizontal line.

## Dependencies

Ruby 1.8 or higher is installed on the target machine.
Rspec gem  to run specs which are written in pather_spec.rb.
Install Rspec via `gem install rspec`
Run specs like : `rspec pather_spec.rb`

## How to Run

ruby pather.rb <input.txt> <output.txt>