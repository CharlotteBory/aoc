# frozen_string_literal: true

class Day
  def self.part_one(...)
    new(...).part_one
  end

  def self.part_two(...)
    new(...).part_two
  end

  def initialize(input)
    @input = input
  end

  private

  attr_accessor :input

  def split_lines!
    self.input = input.split("\n")
  end
end
