defmodule RecurseModule do
  # This function demonstrates a recursive call where the recursive step
  # happens before some local computation.
  def recurse_v1(iteration_number) when iteration_number < 10 do
    lots_of_nums = Enum.shuffle(1..100)
    # The recursive call happens here.
    recurse_v1(iteration_number + 1)
    # The result of this sort is not used or returned by the function.
    Enum.sort(lots_of_nums)
  end

  # This function demonstrates a recursive call where the recursive step
  # happens after some local computation.
  # Similar to recurse_v1, it shuffles and sorts a list, but the sort
  # happens before the recursive call. The result of the sort is still
  # effectively discarded as it's not returned.
  def recurse_v2(iteration_number) when iteration_number < 10 do
    lots_of_nums = Enum.shuffle(1..100)
    # The sort happens here.
    Enum.sort(lots_of_nums)
    # The recursive call follows.
    recurse_v2(iteration_number + 1)
  end

  # Calculates the factorial of a given number `num`.
  # It uses a helper function for tail-recursive implementation.
  def factorial(num) do
    factorial_helper(num, 1)
  end

  # Base case for the factorial calculation: when num is 1, return the accumulated product.
  def factorial_helper(num, product) when num === 1 do
    product
  end

  # Recursive step for the factorial calculation:
  # Decrements num and multiplies it with the current product, then calls itself.
  def factorial_helper(num, product) do
    factorial_helper(num - 1, product * num)
  end

  # Calculates "n choose k" (binomial coefficient), which is the number of
  # ways to choose k items from a set of n distinct items without regard to the order.
  # It uses a helper function for the recursive implementation.
  def n_choose_k(n, k) do
    n_choose_k_helper(n, k)
  end

  # Base case 1 for "n choose k": If n equals k, there's only 1 way to choose all items.
  def n_choose_k_helper(n, k) when n === k do
    1
  end

  # Base case 2 for "n choose k": If k is 1, there are n ways to choose 1 item.
  def n_choose_k_helper(n, k) when k === 1 do
    n
  end

  # Recursive step for "n choose k" using Pascal's identity:
  # C(n, k) = C(n-1, k) + C(n-1, k-1)
  # This represents choosing k items from n by either:
  # 1. Not including a specific item (sets_without_x): choosing k from n-1 items.
  # 2. Including a specific item (sets_with_x): choosing k-1 from n-1 items.
  def n_choose_k_helper(n, k) do
    sets_without_x = n_choose_k_helper(n - 1, k)
    sets_with_x = n_choose_k_helper(n - 1, k - 1)

    sets_without_x + sets_with_x
  end
end

# Example usage of the factorial function (commented out)
# IO.puts(RecurseModule.factorial(5))

# Example usage of the n_choose_k function
n = 10
k = 5
IO.puts("N-Choose-K(#{n}, #{k}): #{RecurseModule.n_choose_k(n, k)}")
