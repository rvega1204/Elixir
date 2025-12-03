# This script demonstrates basic Elixir I/O operations and string manipulation.

# Prints "Hello world from Elixir" to the console.
# IO.puts can be called with or without parentheses for single arguments.
# Prints "Hello World!!!" by concatenating two strings.
# Prints an empty line for spacing.

# Prompts the user to enter their name.
# IO.gets reads a line from standard input, including the newline character.
# Removes leading/trailing whitespace, including the newline, from the input.
# Prints a personalized greeting using string interpolation.

# Prompts the user to enter their age.
# The following lines show an alternative, commented-out way to process the age.
# This block demonstrates the use of the pipe operator (`|>`) for sequential transformations.
# Reads the age input.
# Trims whitespace from the input string.
# Converts the trimmed string to an integer.

# Prints an empty line for spacing.
# Displays the current age of the user.
# Calculates and displays the user's age in ten years.

IO.puts("Hello world from Elixir")
IO.puts "Hello world from Elixir"
IO.puts("Hello " <> "World!!!")
IO.puts("")

#prompt for a name
raw_name = IO.gets("What is your name? ")
name = String.trim(raw_name)
IO.puts("Hello #{name}!!!\n")

#prompt for an age
raw_age = IO.gets("How old are you? ")
#remove any leading and trailing spaces
age_string = String.trim(raw_age)
#convert the string to an int so that I can do some math
age = String.to_integer(age_string)

#pipe operator
age = IO.gets("How old are you? ")
  |> String.trim
  |> String.to_integer

IO.puts("")
IO.puts("Right now #{name} is #{age} years old.")
IO.puts("In ten years #{name} will be #{age + 10}")