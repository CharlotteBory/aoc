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

input = File.open(input_path).read.split("\n")

# Part I
x = 1
cycle = 1


x_values = input.each_with_object([1]) do |signal, x_values|
  next x_values << x if signal == "noop"
  value = signal.split(" ").last.to_i
  x_values.push(x, x + value)
  x += value
end

# p x_values
strengths = []

CYCLE_INDEXES = [19, 59, 99, 139, 179, 219]
x_values.each_with_index do |x, i|
  next unless CYCLE_INDEXES.include?(i)
  [i, x]

  strengths << (i + 1) * x
end
p strengths.sum

# Part II
screen = []
x_values.each_slice(40) do |group|
  row = Array.new(40, ".")
  group.each_with_index do |x, i|
    sprite = (x-1..x+1)
    row[i] = "█" if sprite.include?(i)
  end
  screen << row
end

screen.each do |line|
  puts line.join
end

p x_values.length
