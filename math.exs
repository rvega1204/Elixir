@moduledoc """
This script demonstrates basic arithmetic operations and type conversions in Elixir.
It covers addition, multiplication, and potentially other operations.
"""

#addition
IO.puts(1 + 2 + 3 + 4)

#multiplication
IO.puts(1 * 2 * 3 * 4)

#multiplication
IO.puts(12345 * 23456 * 34567 * 47890)

#addition
IO.puts(1.0 + 2.0 + 3.0 + 4.0)

#addition
IO.puts(0.1 + 0.02 + 0.003 + 0.0004)

#this will not work
#IO.puts(.1 + .02 + .003 + .0004)

IO.puts(10.0 / 3.0)
IO.puts(10 / 3)

#integer division
IO.puts(div(10, 3))
IO.puts(rem(10, 3))

#convert integer to string
str = Integer.to_string(123)
IO.puts(str)
IO.inspect(str)

#convert string to integer
num = String.to_integer("123")
IO.puts(is_integer(num))
IO.puts(is_number(num))

#convert string to float
num = String.to_float("123.0")
IO.puts(is_integer(num))
IO.puts(is_number(num))

#calculate years until retirement
age = 50
retirement_age = 65
years_until_retirement = retirement_age - age

IO.puts("At the age of #{age} you have #{years_until_retirement} years until retirement")