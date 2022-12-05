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

class SupplyStacksParser
  attr_reader :input, :stacks, :instructions
  private attr_reader :starting_positions, :stack_number

  def initialize(input:)
    @input = input
  end

  def parse_input
    @starting_positions = extract_starting_positions(input)
    @instructions = extract_instructions(input)
    @stack_number = extract_number_of_stacks(input)
    self
  end

  def stackify
    @stacks = starting_positions
      .map { |s| s.ljust(stack_number * 4 - 1) }
      .map { |s| s.gsub("    ", "[.]") }
      .map { |s| s.gsub(" ", "") }
      .map { |s| s.gsub("[", "").gsub("]", "") }
      .map { |s| s.chars }
      .transpose
      .map(&:reverse)
      .map { |a| a.select { |l| l != "." } }
      .map { |s| Stack.new(s) }
    self
  end

  private

  def extract_starting_positions(input)
    input.take_while { |l| l.include?("[") }
  end

  def extract_instructions(input)
    start_index = input.find_index { |l| l.start_with?("move") }
    input[start_index..]
  end

  def extract_number_of_stacks(input)
    input.find { |l| l.start_with?(" 1") }[-1].to_i
  end
end

class CraneOperator
  attr_reader :instructions
  attr_accessor :stacks

  def initialize(stacks:, instructions:)
    @stacks = stacks
    @instructions = instructions
  end

  def fulfill_instructions
    instructions.each { |i| fulfill_instruction(stacks, i) }
    stacks
  end

  private

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
  end
end

data = SupplyStacksParser.new(input: input).parse_input.stackify

stacks = data.stacks

stacks = CraneOperator.new(stacks: stacks, instructions: data.instructions).fulfill_instructions


p stacks.map(&:pop).join
