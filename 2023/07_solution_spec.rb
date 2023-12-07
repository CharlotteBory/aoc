# frozen_string_literal: true

require_relative "07_solution"

describe Day07 do
  let(:input) do
    <<~Str
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    Str
  end

  describe ".part_one" do
    subject { described_class.part_one(input) }

    let(:solution) { 6440 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { described_class.part_two(input) }

    let(:solution) { nil }

    it { is_expected.to eq(solution) }
  end
end
