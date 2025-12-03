@moduledoc """
A module for formatting names in various ways.

It provides several `format/` functions to handle different numbers of name parts
(first, middle, last) and specific name cases.
"""

  @doc """
  Formats the name "John" with a middle and last name.

  It uses "Jack" as a nickname and includes the first initial of the middle name.

  ## Examples
      iex> NameFormatter.format("John", "Fitzgerald", "Kennedy")
      "Kennedy, John (Jack) F."
  """
defmodule NameFormatter do
  def format("John", middle, last) do
    "#{last}, John (Jack) #{String.first(middle)}."
  end

  @doc """
  Formats the name "Robert" with a middle and last name.

  It uses "Bob" as a nickname and includes the first initial of the middle name.

  ## Examples
      iex> NameFormatter.format("Robert", "Francis", "Kennedy")
      "Kennedy, Robert (Bob) F."
  """
  def format("Robert", middle, last) do
    "#{last}, Robert (Bob) #{String.first(middle)}."
  end

  def format(first, middle, last) do
    "#{last}, #{first} #{String.first(middle)}."
  end

  def format(first, last) do
    "#{last}, #{first}"
  end

  def format(sole_name) do
    "The one and only #{sole_name}"
  end
end

formatted_name = NameFormatter.format("Jack", "John", "Sparrow")
IO.puts(formatted_name)

formatted_name = NameFormatter.format("John", "Fitzgerald", "Kennedy")
IO.puts(formatted_name)

formatted_name = NameFormatter.format("Robert", "Francis", "Kennedy")
IO.puts(formatted_name)

formatted_name = NameFormatter.format("Jack", "Kerouak")
IO.puts(formatted_name)

formatted_name = NameFormatter.format("Kobe")
IO.puts(formatted_name)