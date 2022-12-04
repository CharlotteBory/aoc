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
  if pair[0][0] <= pair[1][0] && pair[0][1] >= pair[1][1] || pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1]
    complete_overlaps += 1
  end
  unless pair[0][1] < pair[1][0] || pair[0][0] > pair[1][1]
    overlaps += 1
  end
end
p overlaps
