# frozen_string_literal: true

require_relative "../shared/day"

class Day05 < Day
  def initialize(input)
    super
  end

  def part_one
    Almanac.new(input).min_location_for_seeds
  end

  def part_two
    Almanac.new(input).min_location_for_seed_ranges
  end
end

class Almanac
  def initialize(input)
    @input = input
    @seeds = input.split(/\n/)[0].scan(/(\d+)\s*/).flatten.map(&:to_i)
    @seed_to_soil = parse(header: "seed-to-soil map:", next_header: "soil-to-fertilizer map:")
    @soil_to_fertilizer = parse(header: "soil-to-fertilizer map:", next_header: "fertilizer-to-water map:")
    @fertilizer_to_water = parse(header: "fertilizer-to-water map:", next_header: "water-to-light map:")
    @water_to_light = parse(header: "water-to-light map:", next_header: "light-to-temperature map:")
    @light_to_temperature = parse(header: "light-to-temperature map:", next_header: "temperature-to-humidity map:")
    @temperature_to_humidity = parse(header: "temperature-to-humidity map:", next_header: "humidity-to-location map:")
    @humidity_to_location = parse(header: "humidity-to-location map:")
    @seed_ranges = @seeds.each_slice(2).map { |a, b| (a..a+b-1) }
  end

  def parse(header:, next_header: nil)
    if next_header
      maps = input.split("\n#{header}\n")[1].split("\n#{next_header}\n")[0]
    else
      maps = input.split("\n#{header}\n")[1]
    end
    Map.new(maps)
  end

  def min_location_for_seeds
    @seeds.map do |seed|
      @seed_to_soil.map_value(seed)
    end.map do |soil|
      @soil_to_fertilizer.map_value(soil)
    end.map do |fertilizer|
      @fertilizer_to_water.map_value(fertilizer)
    end.map do |water|
      @water_to_light.map_value(water)
    end.map do |light|
      @light_to_temperature.map_value(light)
    end.map do |temperature|
      @temperature_to_humidity.map_value(temperature)
    end.map do |humidity|
      @humidity_to_location.map_value(humidity)
    end.min
  end

  def min_location_for_seed_ranges
    soil_ranges = @seed_ranges.flat_map do |seed_range|
      @seed_to_soil.map_range(seed_range)
    end
    p soil_ranges
    fertilizer_ranges = soil_ranges.flat_map do |soil_range|
      # p soil_range
      @soil_to_fertilizer.map_range(soil_range)
    end
    p fertilizer_ranges
    water_ranges = fertilizer_ranges.flat_map do |fertilizer_range|
      # p fertilizer_range
      @fertilizer_to_water.map_range(fertilizer_range)
    end
    p water_ranges
    light_ranges = water_ranges.flat_map do |water_range|
      # p water_range
      @water_to_light.map_range(water_range)
    end
    p light_ranges
    temperature_ranges = light_ranges.flat_map do |light_range|
      @light_to_temperature.map_range(light_range)
    end
    p temperature_ranges
    humidity_ranges = light_ranges.flat_map do |temperature_range|
      @temperature_to_humidity.map_range(temperature_range)
    end
    location_ranges = humidity_ranges.flat_map do |humidity_range|
      @humidity_to_location.map_range(humidity_range)
    end
    location_ranges.map(&:begin).min
  end

  private

  attr_reader :input
end

class MapLine
  attr_reader :source_range, :destination_range, :source_start, :destination_start, :length

  def initialize(destination_start, source_start, length)
    @length = length
    @destination_start = destination_start
    @source_start = source_start
    @source_range = (source_start..source_start + length)
    @destination_range = (destination_start..destination_start + length)
  end

  def map_value(value)
    source_range.cover?(value) ? value + increment : nil
  end

  def increment = destination_start - source_start
  def source_end = source_start + length
end

class Map
  def initialize(input)
    @map_lines = input.split("\n").map { MapLine.new(*_1.split(" ").map(&:to_i)) }.flatten
    sort_map_lines!
  end

  def map_value(value)
    mapped_value = @map_lines.map { |map_line| map_line.map_value(value) }.compact
    mapped_value.empty? ? value : mapped_value.first
  end

  def map_range(range)
    # binding.pry
    overlapping_map_lines = @map_lines.select { |map_line| overlap(range, map_line.source_range) }

    return [range] if overlapping_map_lines.empty?

    if overlapping_map_lines.count == 1 && overlapping_map_lines.first.source_range.cover?(range)
      map_line = overlapping_map_lines.first
      return [((range.begin + map_line.increment)..(range.end + map_line.increment))]
    end

    ranges = []

    if range.begin < overlapping_map_lines.first.source_start
      ranges << (range.begin..(overlapping_map_lines.first.source_start - 1))
    end

    overlapping_map_lines.each do |map_line|
      ranges << (([map_line.source_start, range.begin].max + map_line.increment)..([map_line.source_end, range.end].min + map_line.increment))
    end

    if range.end > overlapping_map_lines.last.source_end
      ranges << ((overlapping_map_lines.first.source_end + 1)..range.end)
    end

    ranges
  end

  def sort_map_lines!
    @map_lines = @map_lines.sort { |map_line| map_line.source_start }
  end

  def overlap(a, b)
    a.cover?(b.begin) || a.cover?(b.end) || b.cover?(a.begin) || b.cover?(a.end)
  end
end
