# Define a list of Alan Turing's graduation years
turing_graduation_years = [1934, 1935, 1938]
IO.inspect(turing_graduation_years)

# Prepend an element (Turing's high school graduation year) to the list
turing_including_hs = [1931 | turing_graduation_years]
IO.inspect(turing_including_hs)

# Destructure a list into individual variables
[ba, ma, phd] = turing_graduation_years
IO.puts("Alan Turing graduated with a B.A in #{ba}")
IO.puts("Alan Turing graduated with a M.A. in #{ma}")
IO.puts("Alan Turing graduated with a PhD in #{phd}")

# Check for membership in a list
y2k_grad? = 2000 in turing_graduation_years
IO.puts("Did Alan Turing earn a degree in 2000? #{y2k_grad?}")

# Define a list of Grace Hopper's graduation years
hopper_graduation_years = [1928, 1930, 1934]
# Concatenate two lists
all_graduation_years = turing_graduation_years ++ hopper_graduation_years
IO.inspect(turing_graduation_years)
IO.inspect(hopper_graduation_years)
IO.inspect(all_graduation_years)

# Find the difference between two lists (elements in the first list not in the second)
diff = hopper_graduation_years -- turing_graduation_years
IO.inspect(diff)

diff = turing_graduation_years -- hopper_graduation_years
IO.inspect(diff)

# Destructure a list into its head and tail
[undergraduate_degree | graduate_degrees] = hopper_graduation_years
IO.inspect(undergraduate_degree)
IO.inspect(graduate_degrees)

# Define a module to encapsulate degree-related functions
defmodule Degrees do
  # Public function to reverse and print degrees
  def reverse_degrees(grad_years) do
    reverse_helper(grad_years)
  end

  # Private helper function for reverse_degrees - base case: empty list
  defp reverse_helper([]) do
    IO.puts("No Degrees earned")
  end

  # Private helper function for reverse_degrees - base case: single element list
  defp reverse_helper([head | []]) do
    IO.puts("Degree earned in #{head}")
  end

  # Private helper function for reverse_degrees - recursive case
  # Uses tail recursion to print elements in reverse order after the recursive call
  defp reverse_helper([head | tail]) do
    reverse_helper(tail)
    IO.puts("Degree earned in #{head}")
  end

  # Public function to check if a degree was earned in 1930
  def degree_earned_in_year_1930?(grad_years) do
    year_finder(grad_years)
  end

  # Private helper function for year_finder - base case: empty list, year not found
  defp year_finder([]) do
    false
  end

  # Private helper function for year_finder - base case: 1930 found at the head
  defp year_finder([1930 | _tail]) do
    true
  end

  # Private helper function for year_finder - recursive case: check the tail
  defp year_finder([_head | tail]) do
    year_finder(tail)
  end

  # Public function to calculate the length of education (span of years + 4 for initial degree)
  def length_of_education([]) do
    0
  end

  # Calculates the difference between the min and max year, then adds 4 years
  def length_of_education(grad_years) do
    [first_year | _] = grad_years # Assume the list is not empty here due to the first clause
    difference_helper(grad_years, first_year, first_year) + 4
  end

  # Private helper for length_of_education - base case: list exhausted, return the difference
  defp difference_helper([], min_year, max_year) do
    max_year - min_year
  end

  # Private helper for length_of_education - recursive case: update min/max and continue
  defp difference_helper([head | tail], min_year, max_year) do
    new_min = min_year(head, min_year)
    new_max = max_year(head, max_year)
    difference_helper(tail, new_min, new_max)
  end

  # Private helper to find the minimum of two years
  defp min_year(first_year, second_year) when first_year <= second_year do
    first_year
  end

  defp min_year(_first_year, second_year) do
    second_year
  end

  # Private helper to find the maximum of two years
  defp max_year(first_year, second_year) when first_year >= second_year do
    first_year
  end

  defp max_year(_first_year, second_year) do
    second_year
  end

  # Public function to count occurrences of a specific year in the graduation list
  def count_degrees_in_year(grad_years, year) do
    count_helper(grad_years, year, 0)
  end

  # Private helper for count_degrees_in_year - base case: list exhausted, return total count
  defp count_helper([], _year, count) do
    count
  end

  # Private helper for count_degrees_in_year - recursive case: year matches, increment count
  defp count_helper([year | tail], year, count) do
    count_helper(tail, year, count + 1)
  end

  # Private helper for count_degrees_in_year - recursive case: year doesn't match, continue
  defp count_helper([_head | tail], year, count) do
    count_helper(tail, year, count)
  end
end

# Call the reverse_degrees function
Degrees.reverse_degrees(hopper_graduation_years)

# Test degree_earned_in_year_1930? function
grad_in_1930 = Degrees.degree_earned_in_year_1930?([1928, 1930, 1934])
IO.puts("Graduated in 1930?: #{grad_in_1930}")
grad_in_1930 = Degrees.degree_earned_in_year_1930?([1928, 1931, 1934])
IO.puts("Graduated in 1930?: #{grad_in_1930}")

# Calculate and print the length of education from combined years
length_of_education = Degrees.length_of_education(hopper_graduation_years ++ turing_graduation_years)
IO.puts("Length: #{length_of_education}")

# Count degrees earned in a specific year from combined years
year = 1934
num_degrees = Degrees.count_degrees_in_year(hopper_graduation_years ++ turing_graduation_years, year)
IO.puts("The number of degrees earned in #{year} is #{num_degrees}")
