# frozen_string_literal: true

require_relative "../shared/day"

class Day08 < Day
  def initialize(input)
    super
    split_lines!
  end

  def part_one
    Map.new(input[2..-1]).step_count(input[0])
  end

  def part_two
    Map.new(input[2..-1]).step_count2(input[0])
  end
end

class Map
  PATTERN = /(?<node>-?\w{3}) = \((?<left>-?\w{3}), (?<right>-?\w{3})\)/

  def initialize(graph)
    @graph = parse(graph)
  end

  def step_count(directions)
    count = 0
    node = "AAA"
    while node != "ZZZ" do
      directions.chars.each do |direction|
        break if node == "ZZZ"

        if direction == "L"
          node = @graph[node]["left"]
        else
          node = @graph[node]["right"]
        end
        count += 1
      end
    end
    count
  end

  def step_count2(directions)
    nodes = @graph.keys.select { |k,v| k[-1] == "A" }
    nodes_steps_to_z = {}
    nodes.each do |node|
      count = 0
      while node[-1] != "Z" do
        directions.chars.each do |direction|
          break if node[-1] == "Z"

          if direction == "L"
            node = @graph[node]["left"]
          else
            node = @graph[node]["right"]
          end
          count += 1
        end
      end
      nodes_steps_to_z[node] = count
    end
    nodes_steps_to_z.values.reduce(1) { |multiplier, n| multiplier.lcm(n) }
  end

  private

  def parse(graph)
    hash = {}
    graph.each do |line|
      captures = line.match(PATTERN).named_captures
      hash[captures["node"]] = captures.slice("right", "left")
    end
    hash
  end
end
