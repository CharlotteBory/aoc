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
  attr_reader :signals, :map
  private attr_reader :signals, :input
  private attr_writer :map

  SIGNAL = /Sensor at x=(?<sensor_x>-?\d+), y=(?<sensor_y>-?\d+): closest beacon is at x=(?<beacon_x>-?\d+), y=(?<beacon_y>-?\d+)/
  COVERED = "#".freeze
  BEACON = "B".freeze

  def initialize(input)
    @input = input
    @map = Hash.new
    build_signals
    map_beacons
  end

  def mark_around_sensors
    signals.each do |signal|
      mark_around_sensor(signal["sensor_x"], signal["sensor_y"], distance(signal))
    end
  end

  def captured_on_row(index)
    map.select { |k, v| k.split("_").last.to_i == index && v == COVERED }.size
  end

  private

  def mark_around_sensor(sensor_x, sensor_y, distance)
    for x in (sensor_x - distance..sensor_x + distance) do
      for y in (sensor_y - distance..sensor_y + distance) do
        in_range = (sensor_x - x).abs + (sensor_y - y).abs <= distance
        map[key(x,y)] ||= COVERED if in_range
      end
    end
  end

  def build_signals
    @signals ||= input.map { |l| l.match(SIGNAL).named_captures.transform_values(&:to_i)}
  end

  def map_beacons
    signals.each { |s| map[key(s["beacon_x"], s["beacon_y"])] = BEACON }
  end

  def key(x, y)
    [x, y].join("_")
  end

  def distance(signal)
    (signal["sensor_x"] - signal["beacon_x"]).abs + (signal["sensor_y"] - signal["beacon_y"]).abs
  end
end

cave = Cave.new(input)
cave.mark_around_sensors
p cave.captured_on_row(10)
