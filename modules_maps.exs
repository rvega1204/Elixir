defmodule SimpleDateFormatter do
  @moduledoc """
  A module for creating, validating, and formatting dates.
  It handles leap years and provides different string representations of dates.
  """

  @doc """
  Creates a date map if the month and day are within valid ranges (1-12 for month, 1-31 for day).
  It calls `get_valid_day` to ensure the day is valid for the given month and year.
  """
  def create_date(month, day, year) when month >= 1 and month <= 12 and day >= 1 and day <= 31 do
    %{month: month, day: get_valid_day(month, day, year), year: year}
  end

  @doc """
  Returns a default date map (January 1, 2000) if the input month or day is invalid.
  """
  def create_date(_month, _day, _year) do
    %{month: 1, day: 1, year: 2000}
  end

  @doc """
  Determines the valid day for a given month and year.
  If the provided day exceeds the number of days in that month, it defaults to 1.
  """
  def get_valid_day(month, day, year) do
    days_in_months = get_days_in_months(is_leap_year?(year))
    num_days = days_in_months[month]

    cond do
      day <= num_days -> day
      :bad_day -> 1
    end
  end

  @doc """
  Returns a map of days in each month for a leap year.
  It updates February to 29 days.
  """
  def get_days_in_months(true) do
    %{get_days_in_months(false) | 2 => 29}
  end

  @doc """
  Returns a map of days in each month for a common year.
  """
  def get_days_in_months(_is_leap_year) do
    %{
      1 => 31,
      2 => 28,
      3 => 31,
      4 => 30,
      5 => 31,
      6 => 30,
      7 => 31,
      8 => 31,
      9 => 30,
      11 => 30,
      10 => 31,
      12 => 31
    }
  end

  @doc """
  Checks if a given year is a leap year according to the Gregorian calendar rules.
  """
  def is_leap_year?(year) do
    cond do
      rem(year, 400) == 0 -> true
      rem(year, 100) == 0 -> false
      rem(year, 4) == 0 -> true
      :year_not_divisible_by_4 -> false
    end
  end

  @doc """
  Formats a date map into a short string format (MM/DD/YYYY).
  """
  def to_string(date) do
    "#{date.month}/#{date.day}/#{date.year}"
  end

  @doc """
  Formats a date map into a long string format (MonthName DayOrdinal, YYYY).
  """
  def to_string(:long, date) do
    month_name = get_month_name(date)
    ordinal = get_ordinal_string(date)
    "#{month_name} #{ordinal}, #{date.year}"
  end

  @doc """
  Calculates the ordinal string for a day number (e.g., "1st", "2nd", "3rd", "4th").
  This clause handles day numbers with two digits by recursively calling the single-digit version.
  """
  def get_ordinal_string(%{:day => day_number}) do
    first_digit = div(day_number, 10)
    second_digit = rem(day_number, 10)
    ordinal = get_ordinal_string(second_digit)
    "#{first_digit}#{ordinal}"
  end

  @doc """
  Returns the ordinal suffix for single-digit day numbers (0-9).
  """
  def get_ordinal_string(day_number) when day_number < 10 do
    first_10_ordinals = get_first_10_ordinals()
    first_10_ordinals[day_number]
  end

  @doc """
  Returns the ordinal suffix for special day numbers (11, 12, 13).
  """
  def get_ordinal_string(day_number) when day_number >= 11 and day_number <= 13 do
    special_ordinals = get_special_ordinals()
    special_ordinals[day_number]
  end

  @doc """
  Returns the full name of the month for a given date map.
  """
  def get_month_name(%{:month => month}) do
    months = %{
      1 => "January",
      2 => "February",
      3 => "March",
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December"
    }

    months[month]
  end

  @doc """
  Returns a map of ordinal suffixes for day numbers 0 through 9.
  """
  def get_first_10_ordinals() do
    %{
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
  end

  @doc """
  Returns a map of ordinal suffixes for the special day numbers 11, 12, and 13.
  """
  def get_special_ordinals() do
    %{11 => "11th", 12 => "12th", 13 => "13th"}
  end
end

test_date = SimpleDateFormatter.create_date(8, 31, 2022)
IO.puts(SimpleDateFormatter.to_string(:long, test_date))

invalid_date = SimpleDateFormatter.create_date(4, 31, 1984)
IO.puts(SimpleDateFormatter.to_string(:long, invalid_date))
