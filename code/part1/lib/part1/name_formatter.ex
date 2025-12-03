defmodule Part1.NameFormatter do
  # Formats names for "John" with a middle initial, using "Jack" as a nickname
  def format("John", middle, last) do
    "#{last}, John (Jack) #{String.first(middle)}."
  end

  # Formats names for "Robert" with a middle initial, using "Bob" as a nickname
  def format("Robert", middle, last) do
    "#{last}, Robert (Bob) #{String.first(middle)}."
  end

  # Formats a name with first, middle, and last names, using the first initial of the middle name
  def format(first, middle, last) do
    "#{last}, #{first} #{String.first(middle)}."
  end

  # Formats a name with first and last names
  def format(first, last) do
    "#{last}, #{first}"
  end

  # Formats a single name, indicating it's a unique name
  def format(sole_name) do
    "The one and only #{sole_name}"
  end

  # Encodes a formatted name into a JSON string and writes it to a file
  def to_json_file(formatted_name, file_path) do
    valid_json_string = Jason.encode!(%{formatted_name: formatted_name})
    handle_file_write(File.write(file_path, valid_json_string))
  end

  # Handles a successful file write operation
  defp handle_file_write(:ok) do
    #do nothing
  end

  # Handles an error during file write operation, printing the reason
  defp handle_file_write({:error, reason}) do
    IO.puts("Error: #{reason}")
  end

  # Main function to demonstrate name formatting and printing
  def main() do
    formatted_name = format("Mark", "Robert", "Mahoney")
    IO.puts(formatted_name)

    formatted_name = format("John", "Fitzgerald", "Kennedy")
    IO.puts(formatted_name)

    formatted_name = format("Robert", "Francis", "Kennedy")
    IO.puts(formatted_name)

    formatted_name = format("Jack", "Kerouak")
    IO.puts(formatted_name)

    formatted_name = format("Prince")
    IO.puts(formatted_name)

    formatted_name = format("Cher")
    IO.puts(formatted_name)
  end
end
