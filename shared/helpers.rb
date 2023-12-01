def deep_copy(object)
  Marshal.load(Marshal.dump(object))
end

def numerize(digit)
  return digit if digit.to_i > 0

  case digit
  when "one" then return "1"
  when "two" then return "2"
  when "three" then return "3"
  when "four" then return "4"
  when "five" then return "5"
  when "six" then return "6"
  when "seven" then return "7"
  when "eight" then return "8"
  when "nine" then return "9"
  end

  "0"
end
