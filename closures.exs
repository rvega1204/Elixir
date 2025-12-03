# Calculates the number of years until retirement.
#
# Args:
#   retirement_age: The age at which one plans to retire.
#   current_age: The current age of the person.
#
# Returns:
#   The number of years remaining until retirement.

# In Elixir, closures are anonymous functions that capture variables from their lexical environment.
# This means that even after the outer function has finished executing, the inner anonymous function
# retains access to the variables that were in scope when it was defined.
# This is demonstrated in the `RetirementCalculator` module below, where `get_retirement_fn`
# returns a function that "remembers" the `retirement_age` it was created with.
retirement_fn = fn (retirement_age, current_age) ->
  retirement_age - current_age
end

years_until_retirement = retirement_fn.(65, 50)
IO.puts("You have #{years_until_retirement} years until retirement")


#closure is a function that has access to variables from its parent scope
defmodule RetirementCalculator do
  def get_retirement_fn(retirement_age) do
    fn (current_age) ->
      retirement_age - current_age
    end
  end
end

optimistic_fn = RetirementCalculator.get_retirement_fn(60)
pesimistic_fn = RetirementCalculator.get_retirement_fn(100)
current_fn = RetirementCalculator.get_retirement_fn(67)

years_until_retirement = optimistic_fn.(49)
IO.puts("Optimistically, you have #{years_until_retirement} years until retirement")
years_until_retirement = pesimistic_fn.(49)
IO.puts("Pessimistically, you have #{years_until_retirement} years until retirement")
years_until_retirement = current_fn.(49)
IO.puts("You have #{years_until_retirement} years until retirement")