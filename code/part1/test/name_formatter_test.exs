defmodule NameFormatterTest do
  use ExUnit.Case

  # Test case for formatting a typical three-part name (first, middle, last).
  test "Format a typical 3 part name" do
    assert(Part1.NameFormatter.format("Mark", "Robert", "Mahoney") == "Mahoney, Mark R.")
  end

  # Test case for formatting a two-part name (first, last).
  test "Format a 2 part name" do
    assert(Part1.NameFormatter.format("Jack", "Kerouac") == "Kerouac, Jack")
  end

  # Test case for formatting a single-part name, which has a special output.
  test "Format a 1 part name" do
    assert(Part1.NameFormatter.format("Prince") == "The one and only Prince")
    assert(Part1.NameFormatter.format("Cher") == "The one and only Cher")
  end

  # Test cases for names with colloquial versions (nicknames).
  test "Format colloquial names" do
    assert(Part1.NameFormatter.format("John", "Fitzgerald", "Kennedy") == "Kennedy, John (Jack) F.")
    assert(Part1.NameFormatter.format("Robert", "Francis", "Kennedy") == "Kennedy, Robert (Bob) F.")
  end

  # Test case for the `to_json_file` function, verifying it creates a valid JSON file
  # with the formatted name.
  test "test json file creation" do
    file_path = "test.json"
    Part1.NameFormatter.to_json_file("Mahoney, Mark R.", file_path)
    {:ok, file_contents} = File.read(file_path)

    valid_json_map = Jason.decode!(file_contents)
    assert(valid_json_map["formatted_name"] == "Mahoney, Mark R.")
  end
end
