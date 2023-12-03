# frozen_string_literal: true

require_relative "03_solution"

describe Day03 do
  let(:input) do
    <<~Str
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    Str
  end

  describe ".part_one" do
    subject { described_class.part_one(input) }

    let(:solution) { 4361 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { described_class.part_two(input) }

    let(:solution) { 467835 }

    it { is_expected.to eq(solution) }
  end
end
