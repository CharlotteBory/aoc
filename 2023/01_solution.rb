# frozen_string_literal: true

class Day01
  def self.part_one(...)
    new(...).part_one
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

  private

  def split_lines!
    self.input = input.split("\n")
  end

  attr_accessor :input
end
