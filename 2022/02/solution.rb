#         /\          *        *        *             __o    *       *           /\
#        /\*\          *      *       *        *    /_| _     *                 /\*\
#       /\O\*\            K  *     K      *        O'_)/ \  *    * .           /\O\*\
#      /*/\/\/\          <')____  <')____    __*   V   \  ) __  * .           /*/\/\/\
#     /\O\/\*\/\          \ ___ )--\ ___ )--( (    (___|__)/ /*     *        /\O\/\*\/\
#    /\*\/\*\/\/\        *  |   |    |   |  * \ \____| |___/ /  * .         /\*\/\*\/\/\
#   /\O\/\/*/\/O/\            |*  |    |   |    \____________/       *    /\O\/\/*/\/O/\
#         ||                                                                      ||
#         ||                                                                      ||
#         ||                        s p o i l e r s                               ||

input_path = File.expand_path(File.dirname(__FILE__)) + "/data.txt"

input = File.open(input_path).read.strip

SCORES_PART1 = {
  "A X": 3 + 1,
  "A Y": 6 + 2,
  "A Z": 0 + 3,
  "B X": 0 + 1,
  "B Y": 3 + 2,
  "B Z": 6 + 3,
  "C X": 6 + 1,
  "C Y": 0 + 2,
  "C Z": 3 + 3,
}

SCORES_PART2 = {
  "A X": 0 + 3,
  "A Y": 3 + 1,
  "A Z": 6 + 2,
  "B X": 0 + 1,
  "B Y": 3 + 2,
  "B Z": 6 + 3,
  "C X": 0 + 2,
  "C Y": 3 + 3,
  "C Z": 6 + 1,
}

# Part 1
p input.split("\n").map { |s| SCORES_PART1[s.to_sym] }.sum

# Part 2
p input.split("\n").map { |s| SCORES_PART2[s.to_sym] }.sum
