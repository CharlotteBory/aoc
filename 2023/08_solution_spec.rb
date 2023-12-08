# frozen_string_literal: true

require_relative "08_solution"

describe Day08 do
  let(:input) do
    <<~Str
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    Str
  end

  describe ".part_one" do
    subject { described_class.part_one(input) }

    let(:solution) { 6 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { described_class.part_two(input) }

    let(:input) do
      <<~Str
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
      Str
    end

    let(:solution) { 6 }

    it { is_expected.to eq(solution) }
  end
end
