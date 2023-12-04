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

  end
end

class ScratchCard
  def initialize(line)
    @played, @winning = line.split(": ")[1].split("|").map { _1.split(" ").map(&:to_i)}
  end

  def score
    count = (@played & @winning).count
    p [count, 2**(count - 1)]
    count > 0 ? 2**(count - 1) : 0
  end
end
