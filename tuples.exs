@moduledoc """
This script demonstrates basic tuple operations in Elixir.
It defines a tuple representing a full name, then extracts and prints its elements.
"""

# Define a tuple representing a full name
full_name = {"Mark", "Robert", "Mahoney"}
# Get the number of elements in the tuple
IO.puts("There are #{tuple_size(full_name)} elements in the tuple")

# Access individual elements by their index (0-based)
first = elem(full_name, 0)
middle = elem(full_name, 1)
last = elem(full_name, 2)

IO.puts(first)
IO.puts(middle)
IO.puts(last)

# Destructuring assignment: bind tuple elements to variables
{first, middle, last} = full_name #{"Mark", "Robert", "Mahoney"}

IO.puts(first)
IO.puts(middle)
IO.puts(last)

# Tuples are immutable; put_elem returns a new tuple
pres_num_26 = {"Teddy", "Roosevelt"}
IO.inspect(pres_num_26)

# put_elem creates a new tuple with the element at the specified index updated
pres_num_32 = put_elem(pres_num_26, 0, "Franklin")
# The new tuple
IO.inspect(pres_num_32)
# The original tuple remains unchanged
IO.inspect(pres_num_26)

# Define a module to demonstrate pattern matching on tuples
defmodule NameFormatter do
  # Pattern match on a tuple with atom :full_name and three elements
  def format({:full_name, first, middle, last}) do
    "#{last}, #{first} #{String.first(middle)}."
  end

  # Pattern match on a tuple with atom :partial_name and two elements
  def format({:partial_name, first, last}) do
    "#{last}, #{first}"
  end

  # Pattern match on a tuple with atom :solo_name and one element
  def format({:solo_name, first}) do
    "The one and only #{first}"
  end
end

# Call the NameFormatter functions with different tuple structures
name = NameFormatter.format({:full_name, "Mark", "Robert", "Mahoney"})
IO.puts(name)
name = NameFormatter.format({:partial_name, "Jack", "Kerouak"})
IO.puts(name)
name = NameFormatter.format({:solo_name, "Cher"})
IO.puts(name)

# File.read returns an {:ok, content} or {:error, reason} tuple
result = File.read("name.txt")
IO.inspect(result)

# Destructure the result of File.read for explicit handling
{status, contents} = File.read("name.txt")
IO.puts("Status of read: #{status}")
IO.puts("Contents of file: #{contents}")

# Define a helper module for robust file reading and error handling
defmodule FileHelper do
  # Wrapper function to read a file and then handle its results
  def read_file_and_print(file_path) do
    handle_read_results(File.read(file_path))
  end

  # Handle successful file read
  def handle_read_results({:ok, file_contents}) do
    IO.puts(file_contents)
  end
  
  # Handle file not found error using pattern matching on the error tuple
  def handle_read_results({:error, :enoent}) do #error no entry
    IO.puts("The file does not exist")
  end

  # Handle error where the path points to a directory, not a file
  def handle_read_results({:error, :eisdir}) do #error is a directory
    IO.puts("You specified a directory not a file")
  end
end

FileHelper.read_file_and_print("name.txt")
FileHelper.read_file_and_print("ThisFileDoesNotExist.exs")