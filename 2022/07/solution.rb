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

require_relative 'directory.rb'

def parse_move(dir, output)
  new_dir = output.split("$ cd ").last
  case new_dir
  when ".."
    dir.parent
  when "/"
    dir.root
  else
    dir.child(new_dir)
  end
end

current_dir = Directory.new(name: "/")

input.each do |output|
  next current_dir = parse_move(current_dir, output) if output.start_with?("$ cd")
  next if output == "$ ls"

  output = output.match(/(?<dir>dir)?(?<size>\d+)?\s(?<name>\D+)/)
  size = output[:size].to_i if output[:size]

  current_dir.add_child(name: output[:name], size: size)
end

root = current_dir.root
dirs = root.calculate_size

# Part 1
p root.size
p root.sum_of_dirs_under(100000)

# Part 2
p "Usage #{root.size}/70000000"
p "Unused: #{70000000 - root.size}"
p "Needed: 30000000"

missing = 30000000 - (70000000 - root.size)
p missing

p root.dirs_over(missing).flatten.min_by { |d| d.size }.size
