current_file_path = File.expand_path(File.path(__FILE__))
input_path = current_file_path.gsub("puzzles", "inputs").gsub(".rb", ".txt")

input = File.open(input_path).read.strip

p input.split("\n\n").map { |a| a.split("\n")}.map { |a| a.map(&:to_i).sum }.max
