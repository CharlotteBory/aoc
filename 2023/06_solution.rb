# frozen_string_literal: true

require_relative "../shared/day"

class Day06 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    RaceSheet.new(input).margin_of_error
  end

  def part_two

  end
end

class RaceSheet
  def initialize(input)
    @times = input[0].scan(/\d+/).map(&:to_i)
    @distances = input[1].scan(/\d+/).map(&:to_i)
    @races = @times.zip(@distances).map { |time, distance| Race.new(time:, distance:)  }
  end

  def margin_of_error
    @races.map(&:ways_to_win).reduce(&:*)
  end
end

class Race
  def initialize(time:, distance:)
    @time = time
    @distance = distance
  end

  def ways_to_win
    count = 0
    (0..@time).each { |t| count += 1 if winning?(t) }
    count
  end

  def winning?(time_pushed)
    time_moving = time - time_pushed
    speed = time_pushed
    moved = time_moving * speed
    moved > distance
  end

  private

  attr_reader :time, :distance
end
