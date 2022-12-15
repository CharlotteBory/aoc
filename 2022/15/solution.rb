#  *        *        *             __o    *       *
#   *      *       *        *    /_| _     *
#      K  *     K      *        O'_)/ \  *    * .
#     <')____  <')____    __*   V   \  ) __  * .
#      \ ___ )--\ ___ )--( (    (___|__)/ /*     *
#     *  |   |    |   |  * \ \____| |___/ /  * .
#          |*  |    |   |    \____________/       *
#
#                s p o i l e r s
require 'pry-byebug'
input_path = File.expand_path(File.dirname(__FILE__)) + "/data.txt"

input = File.open(input_path).read.split("\n")


class Cave
  attr_reader :signals, :map, :width, :range, :outlines
  private attr_reader :input
  private attr_writer :map, :outlines

  SIGNAL = /Sensor at x=(?<sensor_x>-?\d+), y=(?<sensor_y>-?\d+): closest beacon is at x=(?<beacon_x>-?\d+), y=(?<beacon_y>-?\d+)/
  COVERED = "#".freeze
  BEACON = "B".freeze
  MULTIPLIER = 4000000

  def initialize(input, bound: nil)
    @input = input
    @map = Hash.new
    @outlines = Hash.new
    @range = (0..bound)
    build_signals
    set_width
  end

  def covered_on_row(index)
    x_indices = []
    p (width[:min]..width[:max])
    (width[:min]..width[:max]).each do |x|
      signals.each do |s|
        x_indices << x if in_range(x, index, s) && !beacon_or_sensor?(x, index)
      end
    end
    x_indices.uniq.size
  end

  def tuning_frequency
    set_outlines
    beacon_position = find_unique_beacon
    x, y = beacon_position.split("_").map(&:to_i)
    x * MULTIPLIER + y
  end

  private

  def set_outlines
    signals.each { |signal| add_outline(signal) }
  end

  def find_unique_beacon
    # TODO: remove overlapping outlines as you go to avoid checking them twice (uhum 33 times)
    outlines.find { |k, _| p k; signals.none? { |s| in_range(*k.split("_").map(&:to_i), s)  } }.first
  end

  def add_outline(signal)
    p signal
    distance = distance(signal)
    x = signal["sensor_x"]
    y = signal["sensor_y"]
    for i in 0..distance do
      # Ugly, I know
      outlines[key(x + distance + 1 - i, y + i)] = 1 if range.cover?(x + distance + 1 - i) && range.cover?(y + i)
      outlines[key(x - i, y + distance + 1 - i)] = 1 if range.cover?(x - i) && range.cover?(y + distance + 1 - i)
      outlines[key(x - distance - 1 + i, y - i)] = 1 if range.cover?(x - distance - 1 + i) && range.cover?(y - i)
      outlines[key(x + i, y - distance - 1 + i)] = 1 if range.cover?(x + i) && range.cover?(y - distance - 1 + i)
    end


  end

  def beacon_or_sensor?(x, y)
    signals.any? { |s| s["sensor_x"] == x && s["sensor_y"] == y || s["beacon_x"] == x && s["beacon_y"] == y  }
  end

  def in_range(x, y, signal)
    (y - signal["sensor_y"]).abs + (x - signal["sensor_x"]).abs <= signal["distance"]
  end

  def build_signals
    @signals ||= input.map do |l|
      signal = l.match(SIGNAL).named_captures.transform_values(&:to_i)
      signal["distance"] = distance(signal)
      signal
    end
  end

  def set_width
      s = signals.first
      min_x = [s["sensor_x"], s["beacon_x"]].min - s["distance"]
      max_x = [s["sensor_x"], s["beacon_x"]].max + s["distance"]
    signals.each do |s|
      min_x = [min_x, s["sensor_x"] - s["distance"], s["beacon_x"] - s["distance"]].min
      max_x = [max_x, s["sensor_x"] + s["distance"], s["beacon_x"] + s["distance"]].max
    end
    @width = {min: min_x, max: max_x}
  end

  def key(x, y)
    [x, y].join("_")
  end

  def distance(signal)
    (signal["sensor_x"] - signal["beacon_x"]).abs + (signal["sensor_y"] - signal["beacon_y"]).abs
  end
end

# Part I
# cave = Cave.new(input)
# p cave.covered_on_row(3)

# Part II
cave = Cave.new(input, bound: 4000000)
p cave.tuning_frequency

