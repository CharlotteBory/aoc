def possible_flow(next_valve, minutes, current_valve, shortest_paths, graph)
  distance_to_next_valve = shortest_paths[key(current_valve, next_valve)]
  return 0 if distance_to_next_valve.nil?

  minutes += distance_to_next_valve + 1
  return 0 if minutes >= 30

  minutes_left = 30 - minutes
  flow = graph[next_valve]["flow"] * minutes_left

  [minutes, flow, flow.fdiv(distance_to_next_valve + 1) ]
end

puts "Make the best next move"
closed_valves = valves_with_flow.unshift("AA")
minutes = 0
flow = 0

while minutes < 30 && !closed_valves.empty?
  current_valve = closed_valves.shift
  possible_moves = closed_valves.map { |v| possible_flow(v, minutes, current_valve, shortest_paths, graph) }
  time_spent, additional_flow = possible_moves.max_by { |_, flow, flow_per_minute_spent| flow }
  minutes += time_spent
  flow += additional_flow
end

puts flow

















start = valves_with_flow["AA"]
start[0] = 0

to_visit = ["AA"]
minute = 0
p valves_with_flow

while !to_visit.empty? do
  current_valve_key = to_visit.shift
  current_valve = valves_with_flow[current_valve_key]
  current_valve[:visited] = true
  p current_valve_key
  p current_valve
  puts "looking at my children"
  current_valve[:children].each do |c|
    child = valves_with_flow[c]
    p c
    p child

    distance = shortest_paths[key(current_valve_key, c)]
    # binding.pry
    (0..30).each do |departure_time|
      next unless current_valve[departure_time]

      time_at_child = departure_time + distance + 1
      next unless time_at_child < 30

      remaining_time = 30 - time_at_child
      potential_new_flow = current_valve[departure_time].to_i + graph[c]["flow"] * remaining_time

      p ["Time known", time_at_child, c] if child[time_at_child]
      child[time_at_child] = potential_new_flow if child[time_at_child].to_i < potential_new_flow
    end

    to_visit << c unless child[:visited]
  end
end

p valves_with_flow

