# frozen_string_literal: true

require_relative "../shared/day"
require_relative "../shared/helpers"

class Day01 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    first_digits = input.flat_map { _1.match(/^\D*(\d)/).captures }
    last_digits = input.flat_map { _1.match(/^.*(\d)\D*$/).captures }
    first_digits.zip(last_digits).map(&:join).sum(&:to_i)
  end

  def part_two
    first_digits = input.flat_map { _1.match(/(\d|one|two|three|four|five|six|seven|eight|nine).*/).captures }
    last_digits = input.flat_map { _1.match(/^.*(\d|one|two|three|four|five|six|seven|eight|nine)/).captures }

    first_digits.zip(last_digits).map { |a, b| [numerize(a), numerize(b)].join }.sum(&:to_i)
  end
end
