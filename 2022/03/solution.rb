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

input = File.open(input_path).read.strip.split("\n")

# Part 1
p input
    .map { |bags| bags[0..bags.length/2-1].chars & bags[bags.length/2..bags.length].chars }.flatten
    .map { |item| ("a".."z").to_a.concat(("A".."Z").to_a).index(item) + 1 }
    .sum

# Part 2
badges = []

while input.size >= 3 do
  group = input.take(3).map(&:chars)
  badges << (group[0] & group[1] & group[2])[0]
  input = input.drop(3)
end

p badges.map { |item| ("a".."z").to_a.concat(("A".."Z").to_a).index(item) + 1 }
    .sum
