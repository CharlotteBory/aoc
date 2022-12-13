#  *        *        *             __o    *       *
#   *      *       *        *    /_| _     *
#      K  *     K      *        O'_)/ \  *    * .
#     <')____  <')____    __*   V   \  ) __  * .
#      \ ___ )--\ ___ )--( (    (___|__)/ /*     *
#     *  |   |    |   |  * \ \____| |___/ /  * .
#          |*  |    |   |    \____________/       *
#
#                s p o i l e r s
require 'pry-byebug'
input_path = File.expand_path(File.dirname(__FILE__)) + "/data.txt"

input_part1 = File.open(input_path).read.split("\n\n")
  .map { |l| l.split("\n").map { |s| eval s }}

input_part2 = File.open(input_path).read.split("\n")
  .map { |s| eval s }.compact

def compare(left, right)
  left = arrify(left) if left.is_a?(Integer)
  right = arrify(right) if right.is_a?(Integer)

  left.each_with_index do |item, i|
    next if item == right[i]
    return false if right[i].nil?
    return item < right[i] if item.is_a?(Integer) && right[i].is_a?(Integer)

    return compare(item, right[i])
  end

  true
end

def arrify(value)
  [value].flatten
end

pairs = []
input_part1.each_with_index do |(left, right), i|
  pairs << i + 1 if compare(left, right)
end
p pairs.sum

sorted_packets = input_part2.sort { |a, b| compare(a, b) ? -1 : 1 }
dividers_indices = []
dividers = [[[2]], [[6]]]
sorted_packets.each_with_index do |p, i|

  dividers_indices << i + 1 if dividers.include?(p)
end

p dividers_indices.reduce { |i, p| p * i }
