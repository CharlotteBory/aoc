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

def key(a, b)
  [a, b].join("_")
end

def shortest_path(start_point:, graph:, shortest_paths:)
  # puts "Calculating shortest paths from #{start_point}"
  to_visit = [start_point]
  start_point = graph[start_point]
  start_point["distance"] = 0
  while !to_visit.empty?
    current_node = graph[to_visit.shift]
    next if current_node["children"].empty?

    current_node["children"].each do |key|
      child = graph[key]
      if !child["distance"] || current_node["distance"] + 1 < child["distance"]
        child["distance"] = current_node["distance"] + 1
        to_visit << child["node"]
      end
    end
  end
  graph.each { |k, v| shortest_paths[key(start_point["node"], k)] = v["distance"] }
  [reset_graph(graph), shortest_paths]
end

def reset_graph(graph)
  graph.each { |_, v| v.delete("distance") }
end

def total_flow(path, shortest_paths, graph)
  path = path.unshift("AA")
  minutes = 0
  flow = 0
  path.each_with_index do |valve, i|
    next_valve = path[i + 1]
    distance_to_next_valve = shortest_paths[key(valve, next_valve)]
    break if distance_to_next_valve.nil?

    minutes += distance_to_next_valve + 1
    break if minutes >= 30

    minutes_left = 30 - minutes
    flow += graph[next_valve]["flow"] * minutes_left
  end
  flow
end


PATTERN = /Valve (?<node>[A-Z]+) has flow rate=(?<flow>\d+); tunnels? leads? to valves? (?<children>.+)/

graph = Hash.new

puts "Create graph"
input.each do |l|
  captures = l.match(PATTERN).named_captures
  captures["children"] = captures["children"].split(", ")
  captures["flow"] = captures["flow"].to_i
  graph[captures["node"]] = captures
end

minute = 0

shortest_paths = Hash.new
valves_with_flow = graph.select { |k, v| v["flow"].positive? && k != "AA" }.keys

puts "Create distance matrix for valves with flow"
["AA", *valves_with_flow].each do |start_point|
  shortest_path(start_point:, graph:, shortest_paths:)
end

valves_with_flow

# puts "Compute an insane amount of permutations"
# valve_permutations = valves_with_flow.permutation

# puts "Compute best flow"
# best_flow = 0
# valve_permutations.each { |path| best_flow = [best_flow, total_flow(path, shortest_paths, graph)].max }

# puts best_flow
