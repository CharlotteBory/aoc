# frozen_string_literal: true

require_relative "09_solution"

describe Day09 do
  let(:input) do
    <<~Str
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    Str
  end

  describe ".part_one" do
    subject { described_class.part_one(input) }

    let(:solution) { 114 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { described_class.part_two(input) }

    let(:solution) { 2 }

    it { is_expected.to eq(solution) }
  end
end
