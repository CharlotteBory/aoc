require 'pry-byebug'

class Rope
  private attr_accessor :head, :tail
  private attr_reader :map

  def initialize(map)
    @head = {x: 0, y: 0}
    @tail = {x: 0, y: 0}
    @map = map
    update_traces
    # map.print(head, tail)
  end

  def move(direction, count)
    count.times {move_once(direction)}
    # map.print(head, tail)
  end

  private

  def move_once(direction)
    move_head(direction)
    tail_follows
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

  def tail_follows
    return if tail_touches_head
    return catch_up_horizontally if tail_on_same_line
    return catch_up_vertically if tail_on_same_column
    catch_up_diagonally
  end

  def update_traces
    map.head_visits(head[:x], head[:y])
    map.tail_visits(tail[:x], tail[:y])
  end

  def tail_touches_head
    tail == head || ((tail[:x] - head[:x]).abs == 1 && (tail[:y] - head[:y]).abs == 1)
  end

  def tail_on_same_line
    tail[:y] == head[:y]
  end

  def tail_on_same_column
    tail[:x] == head[:x]
  end

  def catch_up_horizontally
    tail[:x] = tail[:x] - head[:x] > 0 ? head[:x] + 1 : head[:x] - 1
  end

  def catch_up_vertically
    tail[:y] = tail[:y] - head[:y] > 0 ? head[:y] + 1 : head[:y] - 1
  end

  def catch_up_diagonally
    case [tail[:x] - head[:x] > 0, tail[:y] - head[:y] > 0]
    when [false, false]
      tail[:x] += 1
      tail[:y] += 1
    when [true, true]
      tail[:x] -= 1
      tail[:y] -= 1
    when [true, false]
      tail[:x] -= 1
      tail[:y] += 1
    when [false, true]
      tail[:x] += 1
      tail[:y] -= 1
    end
  end
end
