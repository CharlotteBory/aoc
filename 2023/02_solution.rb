# frozen_string_literal: true

require_relative "../shared/day"
require_relative "../shared/helpers"

class Day02 < Day
  PART_ONE_MAX_RGB = [12, 13, 14]

  def initialize(input)
    super
    split_lines!
  end

  def part_one
    input.map { |l| Game.new(l) }.select { |g| g.possible?(PART_ONE_MAX_RGB) }.sum(&:id)
  end

  def part_two
    input.map { |l| Game.new(l) }.sum(&:power)
  end
end

class Game
  attr_reader :id

  def initialize(input)
    @id = input.scan(/Game (\d+)/).flatten[0].to_i
    @min_blue = input.scan(/(\d+) blue/).flatten.map(&:to_i).max
    @min_red = input.scan(/(\d+) red/).flatten.map(&:to_i).max
    @min_green = input.scan(/(\d+) green/).flatten.map(&:to_i).max
  end

  def possible?(max_rgb)
    @min_red <= max_rgb[0] && @min_green <= max_rgb[1] && @min_blue <= max_rgb[2]
  end

  def power
    @min_blue * @min_green * @min_red
  end
end
