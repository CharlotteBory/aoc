# frozen_string_literal: true

require_relative "../shared/day"
require_relative "../shared/grid"
require_relative "../shared/helpers"

class Day03 < Day
  def initialize(input)
    super
    @grid = Grid.new(input:)
    split_lines!
    @numbers_to_sum = []
    @gear_ratios = Hash.new([])
  end

  def part_one
    input.each_with_index do |line, i|
      number = []
      symbol_adjacent = false
      line.chars.each_with_index do |chr, j|
        if chr.match?(/\d/)
          number.push(chr)
          symbol_adjacent = symbol_adjacent?(i, j) unless symbol_adjacent
        else
          @numbers_to_sum << number.join.to_i if symbol_adjacent
          number = []
          symbol_adjacent = false
        end
      end
      @numbers_to_sum << number.join.to_i if symbol_adjacent
      number = []
      symbol_adjacent = false
    end
    @numbers_to_sum.sum
  end

  def part_two
    input.each_with_index do |line, i|
      number = []
      adjacent_gears = []
      line.chars.each_with_index do |chr, j|
        if chr.match?(/\d/)
          number.push(chr)
          adjacent_gears << adjacent_gears(i, j)
        else
          adjacent_gears.flatten.uniq.each do |coordinates|
            @gear_ratios[coordinates] =  @gear_ratios[coordinates] + [number.join.to_i]
          end
          number = []
          adjacent_gears = []
        end
      end
      adjacent_gears.flatten.uniq.each do |coordinates|
        @gear_ratios[coordinates] =  @gear_ratios[coordinates] + [number.join.to_i]
      end
      number = []
      adjacent_gears = []
    end
    @gear_ratios.sum { |k, v| v.count == 2 ? v.reduce(&:*) : 0 }
  end

  private

  attr_reader :grid

  def symbol_adjacent?(i, j)
    grid.surroundings_values(x: j, y: i).flatten.any? { _1.match?(/[^\.\d]/) }
  end

  def adjacent_gears(i,j)
    gears = []
    gears << "#{i - 1}_#{j - 1}" if i > 0 && j > 0 && input[i - 1][j - 1] == "*"
    gears << "#{i - 1}_#{j}" if i > 0 && input[i - 1][j] == "*"
    gears << "#{i - 1}_#{j + 1}" if i > 0 && j < input[0].length - 1 && input[i - 1][j + 1] == "*"
    gears << "#{i}_#{j - 1}" if j > 0 && input[i][j - 1] == "*"
    gears << "#{i}_#{j + 1}" if j > 0 && j < input[0].length - 1 && input[i][j + 1] == "*"
    gears << "#{i + 1}_#{j - 1}" if i < input.length - 1 && j > 0 && input[i + 1][j - 1] == "*"
    gears << "#{i + 1}_#{j}" if i < input.length - 1 && j > 0 && input[i + 1][j] == "*"
    gears << "#{i + 1}_#{j + 1}" if i < input.length - 1 && j < input[0].length - 1 && input[i + 1][j + 1] == "*"
    gears
  end
end
