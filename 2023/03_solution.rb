# frozen_string_literal: true

require_relative "../shared/day"
require_relative "../shared/grid"
require_relative "../shared/helpers"

class Day03 < Day
  def initialize(input)
    super
    @grid = Grid.new(input:)
    @numbers_to_sum = []
    @gear_ratios = Hash.new([])
  end

  def part_one
    grid.each_row do |row, i|
      number = []
      symbol_adjacent = false
      row.each_with_index do |chr, j|
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
    grid.each_row do |row, y|
      number = []
      adjacent_gears = []
      row.each_with_index do |chr, x|
        if chr.match?(/\d/)
          number.push(chr)
          adjacent_gears << adjacent_gears(x, y)
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

  def symbol_adjacent?(y, x)
    grid.surroundings_values(x:, y:).flatten.any? { _1.match?(/[^\.\d]/) }
  end

  def adjacent_gears(x, y)
    grid.surroundings_keys(x:, y:) { |v| v == "*" }
  end
end
