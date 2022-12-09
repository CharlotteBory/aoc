require 'pry-byebug'

class LongRope
  private attr_accessor :head, :knots
  private attr_reader :map

  def initialize(map, length)
    @knots = Array.new(length) {{x: 0, y: 0}}
    @map = map
    update_traces
  end

  def move(direction, count)
    count.times {move_once(direction)}
  end

  private

  def move_once(direction)
    move_head(direction)
    rest_follows
    update_traces
  end

  def move_head(direction)
    case direction
    when "R"
      head[:x] += 1
    when "L"
      head[:x] -= 1
    when "U"
      head[:y] += 1
    when "D"
      head[:y] -= 1
    end
  end

  def rest_follows
    rest.each_with_index { |_, i| next_follows(i)}
  end

  def next_follows(i)
    front_knot, knot = knots[i..i + 1]
    return if knot_touches_front(knot, front_knot)
    return catch_up_horizontally(knot, front_knot) if knot_on_same_line(knot, front_knot)
    return catch_up_vertically(knot, front_knot) if knot_on_same_column(knot, front_knot)
    catch_up_diagonally(knot, front_knot)
  end

  def update_traces
    map.head_visits(head[:x], head[:y])
    map.tail_visits(tail[:x], tail[:y])
  end

  def knot_touches_front(knot, front_knot)
    knot == front_knot || ((knot[:x] - front_knot[:x]).abs == 1 && (knot[:y] - front_knot[:y]).abs == 1)
  end

  def knot_on_same_line(knot, front_knot)
    knot[:y] == front_knot[:y]
  end

  def knot_on_same_column(knot, front_knot)
    knot[:x] == front_knot[:x]
  end

  def catch_up_horizontally(knot, front_knot)
    knot[:x] = knot[:x] - front_knot[:x] > 0 ? front_knot[:x] + 1 : front_knot[:x] - 1
  end

  def catch_up_vertically(knot, front_knot)
    knot[:y] = knot[:y] - front_knot[:y] > 0 ? front_knot[:y] + 1 : front_knot[:y] - 1
  end

  def catch_up_diagonally(knot, front_knot)
    case [knot[:x] - front_knot[:x] > 0, knot[:y] - front_knot[:y] > 0]
    when [false, false]
      knot[:x] += 1
      knot[:y] += 1
    when [true, true]
      knot[:x] -= 1
      knot[:y] -= 1
    when [true, false]
      knot[:x] -= 1
      knot[:y] += 1
    when [false, true]
      knot[:x] += 1
      knot[:y] -= 1
    end
  end

  def tail
    knots.last
  end

  def head
    knots.first
  end

  def rest
    knots[1..-1]
  end
end
