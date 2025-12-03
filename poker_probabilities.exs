defmodule Poker do
  @moduledoc """
  A module for calculating poker hand probabilities and determining hand ranks.
  """

  @doc """
  Creates a card map from a card number (0-51).
  Ranks are 2-14 (Ace), Suits are 0-3 (Clubs, Diamonds, Hearts, Spades).
  Default card creation for invalid card numbers (returns 2 of Clubs).
  """
  def create_card(card_num) when card_num >= 0 and card_num <= 51 do
    %{rank: rem(card_num, 13) + 2, suit: div(card_num, 13)}
  end

  def create_card(_card_num) do
    %{rank: 2, suit: 0} #2 of Clubs
  end

  @doc """
  Returns the string representation of a card's rank (e.g., "2", "J", "A").
  """
  def get_rank(card) do
    ranks = %{
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "J",
      12 => "Q",
      13 => "K",
      14 => "A"
    }

    ranks[card.rank]
  end

  @doc """
  Returns the string representation of a card's suit (e.g., "Clubs", "Hearts").
  """
  def get_suit(card) do
    suits = {"Clubs", "Diamonds", "Hearts", "Spades"}
    elem(suits, card.suit)
  end

  @doc """
  Returns a human-readable string for a single card (e.g., "Ace of Spades").
  """
  def card_to_string(card) do
    "#{get_rank(card)} of #{get_suit(card)}"
  end

  @doc """
  Returns a multi-line string for a list of cards, each on a new line.
  """
  def cards_to_string(cards) do
    Enum.reduce(cards, "", fn (card, result) -> result <> card_to_string(card) <> "\n" end)
  end

  @doc """
  Deals a specified number of unique cards from a 52-card deck.
  """
  def deal_cards(num_cards) when num_cards > 0 and num_cards <= 52 do
    Enum.take_random(0..51, num_cards) |> Enum.map(fn (card_num) -> create_card(card_num) end)
  end

  @doc """
  Groups a list of cards by their rank, returning a map where keys are ranks
  and values are lists of cards with that rank.
  """
  def split_cards_by_rank(cards) do
    Enum.group_by(cards, fn (card) -> card.rank end)
  end

  @doc """
  Identifies if there are 5 or more cards of the same suit and returns them.
  Returns an empty list if no flush is found.
  """
  def get_flush_cards(cards) do
    Enum.group_by(cards, fn (card) -> card.suit end)
    |> Map.values()
    |> Enum.find([], fn (cards_same_suit) -> Enum.count(cards_same_suit) >= 5 end)
  end

  @doc """
  Checks if there's a group of `num_cards` with the same rank in the hand.
  Used for checking pairs, three-of-a-kind, four-of-a-kind.
  """
  def has_rank_repeats?(by_rank, num_cards) do
    Map.values(by_rank) |> Enum.any?(fn (cards_same_rank) -> Enum.count(cards_same_rank) === num_cards end)
  end

  @doc """
  Returns a list of counts for each rank group in the hand.
  e.g., [2, 1, 1, 1] for a pair, [3, 2] for a full house.
  """
  def get_hand_rank_frequencies(by_rank) do
    Map.values(by_rank) |> Enum.map(fn (cards_same_rank) -> Enum.count(cards_same_rank) end)
  end

  @doc """
  Adds a "low Ace" (rank 1) to the `by_rank` map if an Ace (rank 14) is present.
  This is for evaluating straights where Ace can be low (A, 2, 3, 4, 5).
  """
  def add_low_aces(by_rank = %{14 => _}) do
    Map.put_new(by_rank, 1, Map.get(by_rank, 14))
  end

  def add_low_aces(by_rank) do
    by_rank
  end

  @doc """
  Determines the best possible poker hand from a given list of cards.
  Evaluates hands in descending order of strength.
  """
  def best_hand(cards) do
    by_rank = split_cards_by_rank(cards)
    flush_cards = get_flush_cards(cards)

    cond do
      is_royal_flush?(flush_cards) -> :royal_flush
      is_straight_flush?(flush_cards) -> :straight_flush
      is_four_of_a_kind?(by_rank) -> :four_of_a_kind
      is_full_house?(by_rank) -> :full_house
      is_flush?(flush_cards) -> :flush
      is_straight?(by_rank) -> :straight
      is_three_of_a_kind?(by_rank) -> :three_of_a_kind
      is_two_pair?(by_rank) -> :two_pair
      is_pair?(by_rank) -> :pair
      true -> :high_card # Default case if no other hand is found
    end
  end

  @doc """
  Checks if the given `flush_cards` constitute a Royal Flush.
  Requires a flush of 10, J, Q, K, A.
  """
  def is_royal_flush?([]) do
    false
  end

  def is_royal_flush?(flush_cards) do
    flush_card_ranks = Enum.map(flush_cards, fn (card) -> card.rank end)
    Enum.all?([10, 11, 12, 13, 14], fn (rank) -> rank in flush_card_ranks end)
  end

  @doc """
  Checks if the given `flush_cards` constitute a Straight Flush.
  """
  def is_straight_flush?([]) do
    false
  end

  def is_straight_flush?(flush_cards) do
    flush_cards_by_rank = split_cards_by_rank(flush_cards)
    is_straight?(flush_cards_by_rank)
  end

  @doc """
  Checks if the hand contains four cards of the same rank.
  """
  def is_four_of_a_kind?(by_rank) do
    has_rank_repeats?(by_rank, 4)
  end

  @doc """
  Checks if the hand contains a Full House (three of a kind and a pair).
  """
  def is_full_house?(by_rank) do
    hand_rank_frequencies = get_hand_rank_frequencies(by_rank)
    full_house_helper(hand_rank_frequencies, 0, 0)
  end

  # Helper for `is_full_house?`: true if one three-of-a-kind and at least one pair, or two three-of-a-kinds (possible with 7 cards)
  defp full_house_helper(_, three_count, two_count) when (three_count === 1 and two_count >= 1) or three_count === 2 do
    true
  end

  # Helper for `is_full_house?`: base case, no more frequencies to check
  defp full_house_helper([], _three_count, _two_count) do
    false
  end

  # Helper for `is_full_house?`: increments three-of-a-kind count
  defp full_house_helper([rank_frequency | tail], three_count, two_count) when rank_frequency === 3 do
    full_house_helper(tail, three_count + 1, two_count)
  end

  # Helper for `is_full_house?`: increments pair count
  defp full_house_helper([rank_frequency | tail], three_count, two_count) when rank_frequency === 2 do
    full_house_helper(tail, three_count, two_count + 1)
  end

  # Helper for `is_full_house?`: discards other frequencies
  defp full_house_helper([_rank_frequency | tail], three_count, two_count) do
    full_house_helper(tail, three_count, two_count)
  end

  @doc """
  Checks if the hand contains a Straight (five cards in sequential rank).
  Considers Ace as both high (A, K, Q, J, 10) and low (A, 2, 3, 4, 5).
  """
  def is_straight?([]) do
    false
  end

  def is_straight?(by_rank) do
    # Add low aces for straight evaluation (A,2,3,4,5)
    by_rank_with_low_aces = add_low_aces(by_rank)
    # Get unique ranks and sort them
    sorted_ranks = Map.keys(by_rank_with_low_aces) |> Enum.sort()
    # Check for a sequence of 5 consecutive ranks
    in_sequence_helper(sorted_ranks)
  end

  # Helper for `is_straight?`: base case with empty list
  defp in_sequence_helper([]) do
    false
  end

  # Helper for `is_straight?`: start checking from first rank
  defp in_sequence_helper([first_rank | tail]) do
    check_sequence(tail, first_rank, 1)
  end

  # Helper for `is_straight?`: found a sequence of 5 consecutive cards
  defp check_sequence(_ranks, _prev_rank, count) when count === 5 do
    true
  end

  # Helper for `is_straight?`: no more ranks to check
  defp check_sequence([], _prev_rank, _count) do
    false
  end

  # Helper for `is_straight?`: check if current rank is consecutive to previous
  defp check_sequence([rank | tail], prev_rank, count) do
    if rank === prev_rank + 1 do
      # Consecutive rank found, increment count
      check_sequence(tail, rank, count + 1)
    else
      # Not consecutive, start a new sequence from this rank
      check_sequence(tail, rank, 1)
    end
  end

  @doc """
  Checks if the hand contains a Flush (five or more cards of the same suit).
  This function assumes `get_flush_cards` has already found a flush.
  """
  def is_flush?([]) do
    false
  end

  def is_flush?(_flush_cards) do
    true
  end

  @doc """
  Checks if the hand contains three cards of the same rank.
  """
  def is_three_of_a_kind?(by_rank) do
    has_rank_repeats?(by_rank, 3)
  end

  @doc """
  Checks if the hand contains two distinct pairs.
  """
  def is_two_pair?(by_rank) do
    hand_rank_frequencies = get_hand_rank_frequencies(by_rank)
    two_pair_helper(hand_rank_frequencies, 0)
  end

  # Helper for `is_two_pair?`: true if two pairs are found
  defp two_pair_helper(_, count) when count === 2 do
    true
  end

  # Helper for `is_two_pair?`: base case, no more frequencies to check
  defp two_pair_helper([], _count) do
    false
  end

  # Helper for `is_two_pair?`: increments pair count
  defp two_pair_helper([rank_frequency | tail], count) when rank_frequency === 2 do
    two_pair_helper(tail, count + 1)
  end

  # Helper for `is_two_pair?`: discards other frequencies
  defp two_pair_helper([_rank_frequency | tail], count) do
    two_pair_helper(tail, count)
  end

  @doc """
  Checks if the hand contains at least one pair.
  """
  def is_pair?(by_rank) do
    has_rank_repeats?(by_rank, 2)
  end

  @doc """
  Simulates a poker game `num_hands` times, dealing `cards_in_hand` cards
  for each hand, and returns the frequency of each hand rank.
  """
  def play_poker(num_hands, cards_in_hand) do
    Enum.map(1..num_hands, fn (_val) -> best_hand(deal_cards(cards_in_hand)) end) |> Enum.frequencies()
  end

  @doc """
  Prints the percentage of each poker hand rank based on the results map.
  """
  def results_to_string(results) do
    num_hands = Enum.reduce(Map.values(results), 0, fn (result, total) -> result + total end)

    IO.puts("Royal Flush      #{:io_lib.format("~.2f", [(Map.get(results, :royal_flush, 0) / num_hands) * 100.0])}%")
    IO.puts("Straight Flush   #{:io_lib.format("~.2f", [(Map.get(results, :straight_flush, 0) / num_hands) * 100.0])}%")
    IO.puts("Four of a Kind   #{:io_lib.format("~.2f", [(Map.get(results, :four_of_a_kind, 0) / num_hands) * 100.0])}%")
    IO.puts("Full House       #{:io_lib.format("~.2f", [(Map.get(results, :full_house, 0) / num_hands) * 100.0])}%")
    IO.puts("Flush            #{:io_lib.format("~.2f", [(Map.get(results, :flush, 0) / num_hands) * 100.0])}%")
    IO.puts("Straight         #{:io_lib.format("~.2f", [(Map.get(results, :straight, 0) / num_hands) * 100.0])}%")
    IO.puts("Three of a kind  #{:io_lib.format("~.2f", [(Map.get(results, :three_of_a_kind, 0) / num_hands) * 100.0])}%")
    IO.puts("Two Pair         #{:io_lib.format("~.2f", [(Map.get(results, :two_pair, 0) / num_hands) * 100.0])}%")
    IO.puts("Pair             #{:io_lib.format("~.2f", [(Map.get(results, :pair, 0) / num_hands) * 100.0])}%")
    IO.puts("High Card        #{:io_lib.format("~.2f", [(Map.get(results, :high_card, 0) / num_hands) * 100.0])}%")
  end
end

# Example usage:
# Simulates 1,000,000 poker hands with 7 cards each and prints the probabilities.
results = Poker.play_poker(1000000, 7)
Poker.results_to_string(results)