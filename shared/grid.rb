class Grid
  attr_reader :width, :height, :grid

  def initialize(x: nil, y: nil, input: nil)
    @grid = input.split("\n").map(&:chars)
    @width = x || @grid[0].length
    @height = y || @grid.length
  end

  def surrounding_values(x:, y:, radius: 1, &block)
    surroundings = []
    for i in (x - radius)..(x + radius) do
      for j in (y - radius)..(y + radius) do
        next unless in_grid?(i, j) && !(i == x && j == y)

        surroundings << grid[j][i] if block_given? && yield(grid[j][i])
        surroundings << grid[j][i] unless block_given?
      end
    end
    surroundings
  end

  def surrounding_keys(x:, y:, radius: 1, &block)
    surroundings = []
    for i in (x - radius)..(x + radius) do
      for j in (y - radius)..(y + radius) do
        next unless in_grid?(i, j) && !(i == x && j == y)

        surroundings << key(i, j) if block_given? && yield(grid[j][i])
        surroundings << key(i, j) unless block_given?
      end
    end
    surroundings
  end

  def key(x, y, separator: "_") = [x, y].join(separator)

  def in_grid?(i, j) = i >= 0 && j >= 0 && i < width && j < height

  def each_row(...) = grid.each_with_index(...)
end
