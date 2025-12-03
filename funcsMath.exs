@moduledoc """
A module containing various mathematical functions.

This module provides functions for calculating powers, checking if a number is prime,
and finding the integer square root of a number.
"""

@doc """
Calculates the power of a base raised to an exponent.

## Examples
    iex> SimpleMath.power(2, 3)
    8
    iex> SimpleMath.power(5, 0)
    1
"""
defmodule SimpleMath do
  def power(_base, exponent) when exponent == 0 do
    1
  end

  def power(base, exponent) do
    power_helper(base, exponent, 1)
  end

  @doc """
  Helper function for calculating the power of a base raised to an exponent.

  ## Examples
      iex> SimpleMath.power_helper(2, 3, 1)
      8
      iex> SimpleMath.power_helper(5, 0, 1)
      1
  """
  defp power_helper(_base, 0, product_so_far) do
    product_so_far
  end

  defp power_helper(base, exponent, product_so_far) do
    power_helper(base, exponent - 1, (base * product_so_far))
  end

  @doc """
  Checks if a number is prime.

  ## Examples
      iex> SimpleMath.is_prime?(2)
      true
      iex> SimpleMath.is_prime?(4)
      false
  """
  def is_prime?(potential_prime) when potential_prime <= 1 do
    false
  end

  def is_prime?(potential_prime) do
    prime_check(potential_prime, 2)
  end

  @doc """
  Helper function for checking if a number is prime.

  ## Examples
      iex> SimpleMath.prime_check(2, 2)
      true
      iex> SimpleMath.prime_check(4, 2)
      false
  """
  defp prime_check(potential_prime, current_val) when (current_val * current_val) > potential_prime do
    true
  end

  defp prime_check(potential_prime, current_val) when rem(potential_prime, current_val) === 0 do
    false
  end

  defp prime_check(potential_prime, current_val) do
    prime_check(potential_prime, current_val + 1)
  end

  @doc """
  Calculates the integer square root of a number.

  ## Examples
      iex> SimpleMath.sqrt(16)
      4
      iex> SimpleMath.sqrt(17)
      4
  """
  def sqrt(num_to_root) do
    middle = find_middle(1, num_to_root)
    sqrt_helper(num_to_root, 1, middle, num_to_root)
  end

  defp sqrt_helper(_num_to_root, _start_pos, middle_pos, _end_pos, :close_enough) do
    middle_pos
  end

  @doc """
  Helper function for calculating the integer square root of a number.

  ## Examples
      iex> SimpleMath.sqrt_helper(16, 1, 4, 16, :too_big)
      4
      iex> SimpleMath.sqrt_helper(17, 4, 5, 17, :too_small)
      5
  """
  defp sqrt_helper(num_to_root, start_pos, middle_pos, _end_pos, :too_big) do
    new_middle = find_middle(start_pos, middle_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, start_pos, new_middle, middle_pos, result)
  end

  @doc """
  Helper function for calculating the integer square root of a number.

  ## Examples
      iex> SimpleMath.sqrt_helper(17, 4, 5, 17, :too_small)
      5
  """
  defp sqrt_helper(num_to_root, _start_pos, middle_pos, end_pos, :too_small) do
    new_middle = find_middle(middle_pos, end_pos)
    result = compare((new_middle * new_middle), num_to_root)
    sqrt_helper(num_to_root, middle_pos, new_middle, end_pos, result)
  end

  @doc """
  Helper function for calculating the integer square root of a number.

  ## Examples
      iex> SimpleMath.sqrt_helper(17, 4, 5, 17)
      5
  """
  defp sqrt_helper(num_to_root, start_pos, middle_pos, end_pos) do
    result = compare((middle_pos * middle_pos), num_to_root)
    sqrt_helper(num_to_root, start_pos, middle_pos, end_pos, result)
  end

  @doc """
  Finds the middle value between two numbers.

  ## Examples
      iex> SimpleMath.find_middle(1, 10)
      5.5
  """
  defp find_middle(start_pos, end_pos) do
    (start_pos + end_pos) / 2
  end

  @doc """
  Compares two numbers and returns a symbol indicating their relationship.

  ## Examples
      iex> SimpleMath.compare(4, 5)
      :too_small
      iex> SimpleMath.compare(5, 4)
      :too_big
      iex> SimpleMath.compare(4, 4)
      :close_enough
  """
  defp compare(first, second) do
    delta = abs(first - second)
    cond do
      delta < 0.001 -> :close_enough
      first > second -> :too_big
      first < second -> :too_small
    end
  end
end

val = SimpleMath.power(10, 0)
IO.puts(val)

val = 2000000011
result = SimpleMath.is_prime?(val)

if(result) do
  IO.puts("#{val} is prime")
else
  IO.puts("#{val} is NOT prime")
end

val = SimpleMath.sqrt(110)
IO.puts(val)