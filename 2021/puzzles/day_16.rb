current_file_path = File.expand_path(File.dirname(__FILE__)) + "/" + File.path(__FILE__)
input_path = current_file_path.gsub(".rb", "_input.txt")

input = File.open(input_path).read.strip

HEX_DICT = {
  "0" => "0000",
  "1" => "0001",
  "2" => "0010",
  "3" => "0011",
  "4" => "0100",
  "5" => "0101",
  "6" => "0110",
  "7" => "0111",
  "8" => "1000",
  "9" => "1001",
  "A" => "1010",
  "B" => "1011",
  "C" => "1100",
  "D" => "1101",
  "E" => "1110",
  "F" => "1111",
}

INVERTED_DICT = HEX_DICT.invert

def hex_to_bits(string)
  string.chars.map { |k| HEX_DICT[k] }.join
end

def parse_literal_value(string)
  a = []
  b = ""
  string.chars.each_slice(5) {|tuple| a.push(tuple.join) }
  a.map { |bit| bit[1..4] if bit.size === 5 }.join.to_i(2)
end

def parse_packet(string)
  version = INVERTED_DICT[string[0..2].rjust(4, "0")]
  type_id = INVERTED_DICT[string[3..5].rjust(4, "0")]
  body = string[6..]

  case type_id
  when "4"
    parse_literal_value(body)
  else
    # parse operator
  end
end

bits = hex_to_bits("D2FE28")

p parse_packet(bits)
