class Grid
  attr_reader :width, :length, :grid

  def initialize(x: nil, y: nil, input: nil)
    @grid = input.split("\n").map(&:chars)
    @width = x || @grid[0].length
    @height = y || @grid.length
  end

  def surroundings_values(x:, y:, radius: 1, &block)
    surroundings = []
    for i in (x - radius)..(x + radius) do
      for j in (y - radius)..(y + radius) do
        in_grid = i >= 0 && j >= 0 && !(i == x && j == y) && i < @width && j < @height
        if block_given?
          surroundings << @grid[j][i] if in_grid && yield(x, y)
        else
          surroundings << @grid[j][i] if in_grid
        end
      end
    end
    surroundings
  end
end
