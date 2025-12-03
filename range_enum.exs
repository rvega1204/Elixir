  @doc """
  Recursively finds the integer square root of a number using binary search.

  This helper function performs the core logic of the square root calculation by
  repeatedly narrowing down the search range.
  """
  @spec sqrt_helper(pos_integer(), pos_integer(), pos_integer(), pos_integer()) :: pos_integer()
  @spec sqrt_helper(pos_integer(), pos_integer(), pos_integer(), pos_integer(), :close_enough | :too_big | :too_small) :: pos_integer()
  defp sqrt_helper(num_to_root, start_pos, middle_pos, end_pos) do
    # Initial call: compare the square of the current middle position to the target number
    result = compare((middle_pos * middle_pos), num_to_root)
    sqrt_helper(num_to_root, start_pos, middle_pos, end_pos, result)
  end

  # Base case: if the square of the middle position is "close enough" (exact match or within tolerance),
  # then middle_pos is our result.
  defp sqrt_helper(_num_to_root, _start_pos, middle_pos, _end_pos, :close_enough) do
    middle_pos
  end

  # Recursive step: if the square of the middle position is "too big",
  # the square root must be in the lower half of the current range.
  # Update the search range to (start_pos, middle_pos) and recurse.
  defp sqrt_helper(num_to_root, start_pos, middle_pos, _end_pos, :too_big) do
    new_middle = find_middle(start_pos, middle_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, start_pos, new_middle, middle_pos, result)
  end

  # Recursive step: if the square of the middle position is "too small",
  # the square root must be in the upper half of the current range.
  # Update the search range to (middle_pos, end_pos) and recurse.
  defp sqrt_helper(num_to_root, _start_pos, middle_pos, end_pos, :too_small) do
    new_middle = find_middle(middle_pos, end_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, middle_pos, new_middle, end_pos, result)
  end

#Enum.each(1..10, &IO.puts/1)

#Enum.each(1..10, fn (val) -> IO.puts(val) end)

defmodule SimpleMath do
  def power(_base, exponent) when exponent == 0 do
    1
  end

  def power(base, exponent) do
    power_helper(base, exponent, 1)
  end

  defp power_helper(_base, 0, product_so_far) do
    product_so_far
  end

  defp power_helper(base, exponent, product_so_far) do
    power_helper(base, exponent - 1, (base * product_so_far))
  end

  def is_prime?(potential_prime) when potential_prime <= 1 do
    false
  end

  def is_prime?(potential_prime) do
    prime_check(potential_prime, 2)
  end

  defp prime_check(potential_prime, current_val) when (current_val * current_val) > potential_prime do
    true
  end

  defp prime_check(potential_prime, current_val) when rem(potential_prime, current_val) === 0 do
    false
  end

  defp prime_check(potential_prime, current_val) do
    prime_check(potential_prime, current_val + 1)
  end

  def sqrt(num_to_root) do
    middle = find_middle(1, num_to_root)
    sqrt_helper(num_to_root, 1, middle, num_to_root)
  end

  defp sqrt_helper(_num_to_root, _start_pos, middle_pos, _end_pos, :close_enough) do
    middle_pos
  end

  defp sqrt_helper(num_to_root, start_pos, middle_pos, _end_pos, :too_big) do
    new_middle = find_middle(start_pos, middle_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, start_pos, new_middle, middle_pos, result)
  end

  defp sqrt_helper(num_to_root, _start_pos, middle_pos, end_pos, :too_small) do
    new_middle = find_middle(middle_pos, end_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, middle_pos, new_middle, end_pos, result)
  end

  defp sqrt_helper(num_to_root, start_pos, middle_pos, end_pos) do
    result = compare((middle_pos * middle_pos), num_to_root)
    sqrt_helper(num_to_root, start_pos, middle_pos, end_pos, result)
  end

  defp find_middle(start_pos, end_pos) do
    (start_pos + end_pos) / 2
  end

  defp compare(first, second) do
    delta = abs(first - second)
    cond do
      delta < 0.001 -> :close_enough
      first > second -> :too_big
      first < second -> :too_small
    end
  end
end

# Iterate through numbers from 1 to 10 and print the square root of each
Enum.each(1..10, fn (val) ->
  root = SimpleMath.sqrt(val)
  IO.puts(root)
end)

# A more concise way to iterate and print the square root of each number
Enum.each(1..10, &(IO.puts(SimpleMath.sqrt(&1))))

# Calculate the square of each number from 1 to 10 and store them in a list, then print each square
squares = Enum.map(1..10, fn (val) -> SimpleMath.power(val, 2) end)
Enum.each(squares, &IO.puts/1)

# Calculate the cube of each number from 1 to 10, then calculate the square root of each cube, and print them
cubes = Enum.map(1..10, fn (val) -> SimpleMath.power(val, 3) end)
roots_of_cubes = Enum.map(cubes, fn (cube) -> SimpleMath.sqrt(cube) end)
Enum.each(roots_of_cubes, &IO.puts/1)

# A piped version of the above operation: calculate cubes, then their square roots, then print them
Enum.map(1..10, fn (val) -> SimpleMath.power(val, 3) end)
|> Enum.map(fn (cube) -> SimpleMath.sqrt(cube) end)
|> Enum.each(&IO.puts/1)

# Filter numbers from 1 to 100 to find primes and print them
primes = Enum.filter(1..100, fn (val) -> SimpleMath.is_prime?(val) end)
Enum.each(primes, &IO.puts/1)

# Filter numbers from 1 to 100 to find non-primes and print them
non_primes = Enum.reject(1..100, fn (val) -> SimpleMath.is_prime?(val) end)
Enum.each(non_primes, &IO.puts/1)

# Find primes from 1 to 10, then sum them up and print the total
primes = Enum.filter(1..10, fn (val) -> SimpleMath.is_prime?(val) end)
sum = Enum.reduce(primes, 0, fn (prime, sum_of_primes) -> prime + sum_of_primes end)
IO.puts("The sum of the primes is #{sum}")

# Check if any number from 1 to 10 is prime and print the boolean result
any_prime = Enum.any?(1..10, fn val -> SimpleMath.is_prime?(val) end)
IO.puts("It is #{any_prime} that there is at least one prime in that range")

# Check if all numbers from 1 to 10 are prime and print the boolean result
all_prime = Enum.all?(1..10, fn val -> SimpleMath.is_prime?(val) end)
IO.puts("It is #{all_prime} that all the values in that range are prime")

