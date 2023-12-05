# frozen_string_literal: true

require "pry-byebug"

class Day
  def self.part_one(...)
    self.timed { new(...).part_one }
  end

  def self.part_two(...)
    self.timed { new(...).part_two }
  end

  def initialize(input)
    @input = input
  end

  private

  attr_accessor :input

  def self.timed(&block)
    start_time = Time.now
    result = yield
    puts "#{((Time.now - start_time) * 1000).round(1)}ms"
    result
  end

  def split_lines!
    self.input = input.split("\n")
  end
end
