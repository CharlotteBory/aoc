class Stack
  attr_accessor :values

  def initialize(values = [])
    @values = values
  end

  def push(new_values)
    new_values = [new_values].flatten
    values.concat(new_values)
  end

  def pop(number = 1)
    values.pop(number)
  end
end
