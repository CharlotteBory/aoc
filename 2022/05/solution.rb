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

require_relative '../../shared/stack.rb'

starting_positions = input.take_while { |l| l.include?("[") }
instructions = input[starting_positions.size + 2..]

stack_number = input[starting_positions.size][-1].to_i

stacks = starting_positions
  .map { |s| s.ljust(stack_number * 4 - 1) }
  .map { |s| s.gsub("    ", "[.]") }
  .map { |s| s.gsub(" ", "") }
  .map { |s| s.gsub("[", "").gsub("]", "") }
  .map { |s| s.chars }
  .transpose
  .map(&:reverse)
  .map { |a| a.select { |l| l != "." } }
  .map { |s| Stack.new(s) }

def fulfill_instruction(stacks, instruction)
  instruction = instruction
    .gsub("move ", "")
    .gsub(" from ", ",")
    .gsub(" to ", ",")
    .split(",")
    .map(&:to_i)
  from = instruction[1] - 1
  crate_nb = instruction[0]
  to = instruction[2] - 1
  crates = stacks[from].pop(crate_nb)
  # Part 1
  # stacks[to].push(crates.reverse)
  # Part 2
  stacks[to].push(crates)
  stacks
end

instructions.each { |i| stacks = fulfill_instruction(stacks, i) }


p stacks.map(&:pop).join
