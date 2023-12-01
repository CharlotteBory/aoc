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

PATTERN = /Valve (?<node>[A-Z]+) has flow rate=(?<flow>\d+); tunnels? leads? to valves? (?<children>.+)/

graph = Hash.new

input.each do |l|
    captures = l.match(PATTERN).named_captures
    captures["children"] = captures["children"].split(", ")
    captures["flow"] = captures["flow"].to_i
    graph[captures["node"]] = captures
  end

p graph
# pressure_released
# minutes
start_point = "AA"

max_release_in_time = Hash.new(0)

to_visit = [start_point]

while !to_visit.empty?
  node_key = to_visit.shift
  current_node = graph[node_key]
  p current_node
  next if current_node["children"].empty?

  current_node["children"].each do |key|
    # binding.pry
    next if current_node["at_minute"] == 28

    child = graph[key]
    current_node_pressure = current_node["pressure_released"] || 0
    current_node_best_time = current_node["at_minute"] || 0
    maybe_new_child_release = current_node_pressure + child["flow"] * (30 - current_node_best_time - 2)
    closed_valve = child["pressure_released"] == 0
    new_max_flow_for_child = max_release_in_time[current_node_best_time + 2] < maybe_new_child_release && maybe_new_child_release > child["pressure_released"].to_i

    if new_max_flow_for_child
      child["pressure_released"] = maybe_new_child_release
      child["at_minute"] = current_node_best_time + 2
      max_release_in_time[child["at_minute"]] = [child["pressure_released"].to_i, max_release_in_time[child["at_minute"].to_i]].max
      to_visit << child["node"]
    end
  end
  p max_release_in_time
end

p max_release_in_time[30]



# valve is closed = I haven't been here before
