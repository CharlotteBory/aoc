# frozen_string_literal: true

require_relative "../shared/day"

class Day09 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    input.map { |l| History.new(l).extrapolation }.sum
  end

  def part_two

  end
end

class History
  def initialize(line)
    @values = line.split(" ").map(&:to_i)
  end

  def extrapolation
    series = @values.dup
    last_nums = [series[-1]]
    while series.sum != 0 do
      new_series = []
      series = series.each_with_index do |el, i|
        break if i == series.count - 1
        new_series << series[i + 1] - el
      end
      last_nums << new_series[-1]
      series = new_series
    end
    extrapolation = 0
    reversed_last_nums = last_nums.reverse
    reversed_last_nums.each_with_index do |num, i|
      break if i == reversed_last_nums.count - 1

      extrapolation += reversed_last_nums[i + 1]
    end
    extrapolation
  end
end
