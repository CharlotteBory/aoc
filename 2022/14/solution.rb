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
  .map { |l| l.split(" -> ") }

p input

class Cave
  attr_accessor :sand_count
  private attr_reader :input, :abyss
  private attr_accessor :map, :reached_abyss

  ROCK = "#".freeze
  SAND = "o".freeze
  SAND_START = [500, 0]

  def initialize(input)
    @input = input
    @map = Hash.new
    plot_rocks
    @abyss = find_abyss
    @reached_abyss = false
    @sand_count = 0
  end

  def fill
    while !reached_abyss do
      drop_sand
    end
    self
  end

  private

  def drop_sand
    x, y = SAND_START
    rested = false

    until rested || reached_abyss do
      if y >= abyss
        self.reached_abyss = true
        next
      end
      if down_free(x, y)
        x, y = drop_down(x, y)
        next
      end
      if down_left_free(x, y)
        x, y = drop_left(x, y)
        next
      end
      if down_right_free(x, y)
        x, y = drop_right(x, y)
        next
      end

      rested = true
      map[key(x,y)] = SAND
      self.sand_count += 1
    end
  end

  def down_free(x, y)
    !map[key(x, y + 1)]
  end

  def down_left_free(x, y)
    return unless x.positive?

    !map[key(x - 1, y +1)]
  end

  def down_right_free(x, y)
    !map[key(x + 1, y +1)]
  end

  def drop_down(x, y)
    [x, y + 1]
  end

  def drop_left(x, y)
    [x - 1, y + 1]
  end

  def drop_right(x, y)
    [x + 1, y + 1]
  end

  def plot_rocks
    input.each { |rock| plot_rock(rock) }
  end

  def find_abyss
    map.keys.map { |key| key.split("_").last.to_i }.max + 1
  end

  def plot_rock(rock)
    rock[0..-2].each_with_index { |start, i| plot_edge(start, rock[i + 1]) }
  end

  def plot_edge(start, finish)
    start = parse_position(start)
    finish = parse_position(finish)

    if start[:x] == finish[:x]
      range(start[:y], finish[:y]).each { |y| map[key(start[:x], y)] = ROCK }
    else
      range(start[:x], finish[:x]).each { |x| map[key(x, start[:y])] = ROCK }
    end
  end

  def parse_position(position)
    [:x, :y].zip(position.split(",").map(&:to_i)).to_h
  end

  def key(x, y)
    [x, y].join("_")
  end

  def range(*ends)
    ([ends[0], ends[1]].min..[ends[0], ends[1]].max)
  end
end

p Cave.new(input).fill.sand_count
