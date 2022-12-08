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

input = File.open(input_path).read.split("\n").map { |l| l.chars.map(&:to_i)}

MAP_SIZE = {y: input.length, x: input[0].length}

# *************************************** #
# ************** P A R T   I ************ #
# *************************************** #
def check_from_left(input, forest)
  puts "Checking from left"
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [y, x].join("-")
      if row[0..x - 1].all? { |height| height < tree }
        forest[location] = 1
      elsif x == 0
        forest[location] = 1
      end
    end
  end

  forest
end

def check_from_right(input, forest)
  puts "Checking from right"
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [y, x].join("-")
      if row[x + 1..-1].all? { |height| height < tree }
        forest[location] = 1
      elsif x == MAP_SIZE[:x]
        forest[location] = 1
      end
    end
  end

  forest
end

def check_from_top(input, forest)
  puts "Checking from top"
  input = input.transpose
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [x, y].join("-")

      if row[0..x - 1].all? { |height| height < tree }
        forest[location] = 1
      elsif x == 0
        forest[location] = 1
      end
    end
  end

  forest
end

def check_from_bottom(input, forest)
  puts "Checking from bottom"
  input = input.transpose
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [x, y].join("-")
      if row[x + 1..-1].all? { |height| height < tree }
        forest[location] = 1
      elsif x == MAP_SIZE[:x]
        forest[location] = 1
      end
    end
  end

  forest
end

def print_map(forest)
  map = Array.new(5) {Array.new(5, 0)}
  forest.each do |k,v|
    y, x = k.split("-").map(&:to_i)
    map[y][x] = v
  end

  map.each { |r| p r }
end

def check_outside_in_view(input)
  forest = Hash.new(0)
  forest = check_from_left(input, forest)
  forest = check_from_right(input, forest)
  forest = check_from_top(input, forest)
  forest = check_from_bottom(input, forest)
  forest.values.sum
end

# Part 1
p check_outside_in_view(input)


# *************************************** #
# ************* P A R T   II ************ #
# *************************************** #

def check_to_left(input, forest)
  puts "Checking to left"
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [y, x].join("-")
      count = 0
      next forest[location] *= count if x == 0
      row[0..x - 1].reverse.each do |height|
        count += 1
        break if height >= tree
      end
      forest[location] *= count
    end
  end

  forest
end

def check_to_right(input, forest)
  puts "Checking to right"
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [y, x].join("-")
      count = 0
      next forest[location] *= count if x == MAP_SIZE[:x]
      row[x + 1..- 1].each do |height|
        count += 1
        break if height >= tree
      end
      forest[location] *= count
    end
  end

  forest
end

def check_to_top(input, forest)
  puts "Checking to top"
  input = input.transpose
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [x, y].join("-")
      count = 0
      next forest[location] *= count if x == 0
      row[0..x - 1].reverse.each do |height|
        count += 1
        break if height >= tree
      end
      forest[location] *= count
    end
  end

  forest
end

def check_to_bottom(input, forest)
  puts "Checking to top"
  input = input.transpose
  input.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      location = [x, y].join("-")
      count = 0
      next forest[location] *= count if x == MAP_SIZE[:y] - 1
      row[x + 1..- 1].each do |height|
        count += 1
        break if height >= tree
      end
      forest[location] *= count
    end
  end

  forest
end

def plot_scenic_view(input)
  forest = Hash.new(1)
  forest = check_to_left(input, forest)
  forest = check_to_right(input, forest)
  forest = check_to_top(input, forest)
  forest = check_to_bottom(input, forest)
end

# Part 2
forest = plot_scenic_view(input)
# print_map(forest)
p forest.values.max

