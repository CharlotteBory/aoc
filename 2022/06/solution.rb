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

input = File.open(input_path).read.strip.chars

def first_uniq_sequence(input, length)
  i = 0
  while i < input.length
    return i + length if input[i.. i + length - 1] == input[i..i + length - 1].uniq

    i += 1
  end
end

# Part 1
p first_uniq_sequence(input, 4)

# Part 2
p first_uniq_sequence(input, 14)
