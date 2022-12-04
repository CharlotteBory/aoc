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

input = input.map { |p| p.split(",").map { |p| p.split("-").map(&:to_i)} }

complete_overlaps = 0
overlaps = 0

input.each do |pair|
  # Part 1
  first_range_includes_second = pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1]
  second_range_includes_first = pair[0][0] <= pair[1][0] && pair[0][1] >= pair[1][1]

  complete_overlaps += 1 if second_range_includes_first || first_range_includes_second

  # Part 2
  lower_bounds_bigger_than_upper = pair[0][1] < pair[1][0] || pair[0][0] > pair[1][1]

  overlaps += 1 unless lower_bounds_bigger_than_upper
end

p complete_overlaps
p overlaps
