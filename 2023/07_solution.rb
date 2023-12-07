# frozen_string_literal: true

require_relative "../shared/day"

class Day07 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    Game.new(input).play!.total_winnings
  end

  def part_two

  end
end

class Game
  attr_reader :total_winnings

  def initialize(input)
    @hands = input.map { |l| l.split(" ") }.map { |hand, bid| Hand.new(hand:, bid: bid.to_i) }
    @hands_count = @hands.count
  end

  def play!
    @total_winnings = @hands.sort.map.with_index { |hand, index| (@hands_count - index) * hand.bid }.sum
    self
  end
end

class Hand
  attr_reader :cards, :bid

  def initialize(hand:, bid:)
    @hand_string = hand
    @cards = hand.chars.map { |c| Card.new(c) }
    @bid = bid
  end

  def self.rank_type(hand)
    cards_per_value = hand.cards.map(&:value).tally.values.sort
    result = case cards_per_value
    when [5] then 1
    when [1, 4] then 2
    when [2, 3] then 3
    when [1, 1, 3] then 4
    when [1, 2, 2] then 5
    when [1, 1, 1, 2] then 6
    else 7
    end

    result
  end

  def to_s
    @hand_string
  end

  def <=>(other)
    type_comp = type_rank <=> other.type_rank
    return type_comp unless type_comp.zero?

    cards <=> other.cards
  end

  def type_rank
    self.class.rank_type(self)
  end
end

class Card
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def value_num
    case value
    when "A"
      14
    when "K"
      13
    when "Q"
      12
    when "J"
      11
    when "T"
      10
    else
      value.to_i
    end
  end

  def <=>(other)
    -(value_num <=> other.value_num)
  end
end

