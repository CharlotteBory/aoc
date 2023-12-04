# frozen_string_literal: true

require_relative "../shared/day"

class Day04 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    input.map { ScratchCard.new(_1) }.sum(&:score)
  end

  def part_two
    Deck.new(input).play!.card_count
  end
end

class ScratchCard
  attr_reader :id

  def initialize(line)
    @id = line.scan(/\d+:/)[0].to_i
    @played, @winning = line.split(": ")[1].split("|").map { _1.split(" ").map(&:to_i)}
  end

  def score
    winning_count > 0 ? 2**(winning_count - 1) : 0
  end

  def winning_count = (@played & @winning).count
end

class Deck
  def initialize(input)
    @cards = input.map { ScratchCard.new(_1) }
    @card_counts = Hash.new(1)
  end

  def play!
    @cards.each { multiply(_1) }
    self
  end

  def card_count
    @card_counts.values.sum
  end

  private

  def multiply(card)
    id = card.id
    @card_counts[id] = 1 unless @card_counts[id] > 1
    score = card.winning_count
    return if score.zero?

    card_count = @card_counts[id]

    ((id + 1)..(id + score)).each do |copy_id|
      @card_counts[copy_id] += card_count
    end
  end
end
