input_path = File.expand_path(File.dirname(__FILE__)) + "/data.txt"

input = File.open(input_path).read.strip

# max cal
p input.split("\n\n").map { |a| a.split("\n")}.map { |a| a.map(&:to_i).sum }.max

# max 3 cal
p input.split("\n\n").map { |a| a.split("\n")}.map { |a| a.map(&:to_i).sum }.max(3).sum

