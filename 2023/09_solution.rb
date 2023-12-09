# frozen_string_literal: true

require_relative "../shared/day"

class Day09 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    input.map { |l| History.new(l).future_extrapolation }.sum
  end

  def part_two
    input.map { |l| History.new(l).past_extrapolation }.sum
  end
end

class History
  def initialize(line)
    @values = line.split(" ").map(&:to_i)
  end

  def future_extrapolation
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

  def past_extrapolation
    series = @values.dup
    first_nums = [series[0]]
    while series.sum != 0 do
      new_series = []
      series = series.each_with_index do |el, i|
        break if i == series.count - 1
        new_series << series[i + 1] - el
      end
      first_nums << new_series[0]
      series = new_series
    end
    extrapolation = 0
    reversed_first_nums = first_nums.reverse
    reversed_first_nums.each_with_index do |num, i|
      break if i == reversed_first_nums.count - 1

      extrapolation = reversed_first_nums[i + 1] - extrapolation
    end
    extrapolation
  end
end
