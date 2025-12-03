defmodule MapsDemo do
  @moduledoc """
  This script demonstrates basic operations with Elixir maps.

  Maps are key-value data structures in Elixir, similar to dictionaries or hash tables in other languages.
  They are defined using the %{} syntax.

  Key operations shown here include:
  - Creating maps with atom keys (e.g., `%{first: "Mark"}`).
  - Accessing map values using `map[:key]` syntax.
  - Merging maps using `Map.merge/2`, which combines two maps. If keys overlap,
    values from the second map (`partial_name` in this case) will override
    values from the first map (`friendly_name`).
  """

  # Create a map with atom keys and string values for a friendly name
  friendly_name = %{:first => "Mark", :last => "Mahoney"}
  IO.inspect(friendly_name)
  # Access map values using the `map[:key]` syntax
  IO.puts(friendly_name[:first])
  IO.puts(friendly_name[:last])

  # Create another map with a middle name
  partial_name = %{:middle => "Robert"}
  IO.inspect(partial_name)

  # Merge two maps. If keys overlap, values from the second map (`partial_name`)
  # will override values from the first map (`friendly_name`).
  full_name = Map.merge(friendly_name, partial_name)
  IO.puts(full_name[:first])
  IO.puts(full_name[:middle])
  IO.puts(full_name[:last])

  # Access map values using dot notation for atom keys (syntactic sugar)
  full_name = Map.merge(friendly_name, partial_name)
  IO.puts(full_name.first)
  IO.puts(full_name.middle)
  IO.puts(full_name.last)

  # Add a new key-value pair to a map if the key does not already exist
  professional_name = Map.put_new(full_name, :highest_degree, "PhD")
  IO.puts("#{professional_name[:first]} #{professional_name[:middle]} #{professional_name[:last]} #{professional_name[:highest_degree]}")

  # Accessing a non-existent key returns `nil`
  IO.puts(full_name[:suffix])
  # Use `Map.get/3` to provide a default value for a non-existent key
  IO.puts("#{full_name[:first]} #{full_name[:middle]} #{full_name[:last]} (#{Map.get(full_name, :suffix, "The First")})")

  # Pattern matching to extract a value from a map
  %{:last => last_name} = professional_name
  IO.puts(last_name)

  # Pattern matching to extract multiple values from a map
  %{:first => first_name, :last => last_name} = professional_name
  IO.puts(first_name)
  IO.puts(last_name)

  # Create a map with integer keys and string values
  first_10_ordinals = %{
    0 => "0th",
    1 => "1st",
    2 => "2nd",
    3 => "3rd",
    4 => "4th",
    5 => "5th",
    6 => "6th",
    7 => "7th",
    8 => "8th",
    9 => "9th"
  }

  IO.inspect(first_10_ordinals)
  IO.puts(first_10_ordinals[0])
  IO.puts(first_10_ordinals[9])

  # Another map with integer keys
  special_ordinals = %{11 => "11th", 12 => "12th", 13 => "13th"}
  IO.inspect(special_ordinals)
  IO.puts(special_ordinals[11])
  IO.puts(special_ordinals[12])
  IO.puts(special_ordinals[13])

  # Merge the two ordinal maps
  all_ordinals = Map.merge(first_10_ordinals, special_ordinals)
  IO.inspect(all_ordinals)
  IO.puts(all_ordinals[0])
  IO.puts(all_ordinals[13])