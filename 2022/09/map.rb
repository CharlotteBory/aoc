class Map
  private attr_reader :tail_trace, :head_trace, :size

  def initialize
    @tail_trace = Hash.new(0)
    @head_trace = Hash.new(0)
    @size = {x: nil, y: nil}
  end

  def visited_by_tail_count
    tail_trace.values.sum
  end

  def visited_by_head_count
    head_trace.values.sum
  end

  def head_visits(x, y)
    head_trace[key(x, y)] = 1
  end

  def tail_visits(x, y)
    tail_trace[key(x, y)] = 1
  end

  def print(head = nil, tail = nil)
    get_size
    p ["size", size]
    matrix = Array.new(size[:y]) {Array.new(size[:x], ".") }
    p tail_trace
    tail_trace.keys.each do |k|
      x, y = parse_key(k)
      matrix[y][x] = "#"
    end
    matrix[head[:y]][head[:x]] = "H" if head
    matrix[tail[:y]][tail[:x]] = "T" if tail
    matrix.reverse.each { |row| p row.join }
  end

  private

  def key(x, y)
    [x, y].join("-")
  end
  def parse_key(key)
    key.split("-").map(&:to_i)
  end

  def get_size
    keys = head_trace.keys.push(*tail_trace.keys)
    keys = keys.map { |k| parse_key(k) }
    size[:x] = keys.map(&:first).max + 1
    size[:y] = keys.map(&:last).max + 1
  end
end
