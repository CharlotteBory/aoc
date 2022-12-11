#  *        *        *             __o    *       *
#   *      *       *        *    /_| _     *
#      K  *     K      *        O'_)/ \  *    * .
#     <')____  <')____    __*   V   \  ) __  * .
#      \ ___ )--\ ___ )--( (    (___|__)/ /*     *
#     *  |   |    |   |  * \ \____| |___/ /  * .
#          |*  |    |   |    \____________/       *
#
#                s p o i l e r s

require 'yaml'

input_path = File.expand_path(File.dirname(__FILE__)) + "/data.yml"

input = YAML.load(File.open(input_path))

NUMBER_OF_ROUNDS = 10000
inspections = Hash.new(0)
MAGIC_NUMBER = input.values.reduce(1) { |pdt, el| pdt * el["Test"].split("divisible by ").last.to_i }

NUMBER_OF_ROUNDS.times do
  input.each do |monkey, info|
    info["Starting items"].each do |item|
      inspections[monkey] += 1
      old = item
      new = eval(info["Operation"])
      # Part I
      # new = new.div(3)
      # Part II
      new = new % MAGIC_NUMBER
      divider = info["Test"].split("divisible by ").last.to_i
      result = (new % divider == 0).to_s
      new_monkey = info["If #{result}"].split("throw to ").last.capitalize
      input[new_monkey]["Starting items"] << new
    end
    info["Starting items"] = []
  end
end

p inspections.values.max(2).reduce(&:*)
