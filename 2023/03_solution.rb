# frozen_string_literal: true

require_relative "../shared/day"
require_relative "../shared/helpers"

class Day03 < Day
  def initialize(input)
    super
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

  def symbol_adjacent?(i, j)
    line_min = i > 0 ? i - 1 : i
    line_max = i == input.count - 1 ? i : i + 1
    col_min = j > 0 ? j -1 : j
    col_max = j == input[0].length - 1 ? j : j + 1
    adjacent_chrs = []

    if line_min != i
      adjacent_chrs << input[line_min][col_min..col_max].chars
    end

    if col_min != j
      adjacent_chrs << input[i][col_min]
    end

    if col_max != j
      adjacent_chrs << input[i][col_max]
    end

    if  line_max != i
      adjacent_chrs << input[line_max][col_min..col_max].chars
    end

    adjacent_chrs.flatten.any? { _1.match?(/[^\.\d]/) }
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
