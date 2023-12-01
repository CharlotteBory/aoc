# frozen_string_literal: true

class Day01
  def self.part_one(...)
    new(...).part_one
  end

  def self.part_two(...)
    new(...).part_two
  end

  def initialize(input)
    @input = input
  end

  def part_one
    split_lines!
    first_digits = input.flat_map { _1.match(/^\D*(\d)/).captures }
    last_digits = input.flat_map { _1.match(/^.*(\d)\D*$/).captures }
    first_digits.zip(last_digits).map(&:join).sum(&:to_i)
  end

  def part_two
    split_lines!
    first_digits = input.flat_map { _1.match(/(\d|one|two|three|four|five|six|seven|eight|nine).*/).captures }
    last_digits = input.flat_map { _1.match(/^.*(\d|one|two|three|four|five|six|seven|eight|nine)/).captures }

    first_digits.zip(last_digits).map { |a, b| [numerize(a), numerize(b)].join }.sum(&:to_i)
  end

  private

  def split_lines!
    self.input = input.split("\n")
  end

  def numerize(string)
    return string if string.to_i > 0

    case string
    when "one" then return "1"
    when "two" then return "2"
    when "three" then return "3"
    when "four" then return "4"
    when "five" then return "5"
    when "six" then return "6"
    when "seven" then return "7"
    when "eight" then return "8"
    when "nine" then return "9"
    end

    "0"
  end

  attr_accessor :input
end
