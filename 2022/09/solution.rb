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
require_relative 'rope.rb'
require_relative 'long_rope.rb'
require_relative 'map.rb'

moves = input.map { |l| l.match(/(?<direction>\w+) (?<count>\d+)/).named_captures }


# Part 1
map = Map.new()
rope = Rope.new(map)

moves.each { |m| rope.move(m["direction"], m["count"].to_i) }

p map.visited_by_tail_count

# Part 2
map = Map.new()

rope = LongRope.new(map, 10)

moves.each { |m| rope.move(m["direction"], m["count"].to_i) }

p map.visited_by_tail_count
