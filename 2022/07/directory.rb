class Directory
  attr_accessor :name, :children, :size, :parent
  attr_reader :name

  def initialize(name:, size: nil, children: [], parent: nil)
    @name = name
    @size = size
    @children = children
    @parent = parent
  end

  def root
    return self unless parent

    parent.root
  end

  def add_child(name:, size: nil)
    return self if children.find { |c| c.name == name }

    children << Directory.new(name: name, size: size, parent: self)
  end

  def child(name)
    children.find { |c| c.name == name }
  end

  def calculate_size
    return size if size

    self.size = children.reduce(0) { |sum, c| sum + c.calculate_size  }
  end

  def sum_of_dirs_under(max, sum = 0)
    return sum unless dir?

    sum += size if dir? && size <=max
    children.each do |child|
      sum += child.sum_of_dirs_under(max, sum) - sum
    end

    sum
  end

  def dir?
    children.size > 0
  end
end
