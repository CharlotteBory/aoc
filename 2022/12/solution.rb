#  *        *        *             __o    *       *
#   *      *       *        *    /_| _     *
#      K  *     K      *        O'_)/ \  *    * .
#     <')____  <')____    __*   V   \  ) __  * .
#      \ ___ )--\ ___ )--( (    (___|__)/ /*     *
#     *  |   |    |   |  * \ \____| |___/ /  * .
#          |*  |    |   |    \____________/       *
#
#                s p o i l e r s

input_path = File.expand_path(File.dirname(__FILE__)) + "/data.txt"

input = File.open(input_path).read.split("\n").map(&:chars)

class ElevationMap
  attr_reader :start, :nodes, :finish, :low_points

  def initialize(nodes:, start:, finish:, low_points:)
    @nodes = nodes
    @start = nodes[start]
    @finish = nodes[finish]
    @low_points = low_points
  end

  def self.build_from_2d_array(array)
    nodes = Hash.new
    start, finish = ["", ""]
    low_points = []
    array.each_with_index do |row, y|
      row.each_with_index do |elevation, x|
        value = clean_elevation(elevation)
        children = accessible_children(x, y, value, array)
        start = key(x, y) if elevation == "S"
        low_points << key(x, y) if value == "a"
        finish = key(x, y) if elevation == "E"
        nodes[key(x, y)] = Node.new(value:, children:)
      end
    end

    self.new(nodes:, start:,  finish:, low_points:)
  end

  def shortest_path(start_point: start)
    to_visit = [start_point]
    start_point.distance = 0
    while !to_visit.empty?
      current_node = to_visit.shift
      next if current_node.children.empty?

      current_node.children.each do |key|
        child = nodes[key]
        if current_node.distance + 1 < child.distance
          child.distance = current_node.distance + 1
          child.from = current_node
          to_visit << child
        end
      end
    end
    finish.distance
  end

  def shortest_path_from_any_low_point
    path_lengths = []
    low_points.each do |start_key|
      path_lengths << shortest_path(start_point: nodes[start_key])
    end
    path_lengths.min
  end

  private

  def self.clean_elevation(elevation)
    return "a" if elevation == "S"
    return "z" if elevation == "E"

    elevation
  end

  def self.accessible_children(x, y, value, array)
    up = y.positive? ? array[y - 1][x] : nil
    right = x < array.first.size - 1 ? array[y][x + 1] : nil
    down = y < array.size - 1 ? array[y + 1][x] : nil
    left = x.positive? ? array[y][x - 1] : nil

    children = []
    children << key(x, y - 1) if up && accessible_elevation(up, value)
    children << key(x + 1, y) if right && accessible_elevation(right, value)
    children << key(x, y + 1) if down && accessible_elevation(down, value)
    children << key(x - 1, y) if left && accessible_elevation(left, value)
    children
  end

  def self.accessible_elevation(elevation, from)
    clean_elevation(elevation).ord <= from.ord + 1
  end

  def self.key(x, y)
    [x, y].join("_")
  end
end

class Node
  INFINITY = 100_000
  attr_accessor :distance, :from
  attr_reader :children

  def initialize(value:, children: [])
    @value = value
    @children = children
    @distance = INFINITY
    @from = nil
  end
end

p ElevationMap.build_from_2d_array(input).shortest_path
p ElevationMap.build_from_2d_array(input).shortest_path_from_any_low_point
