# frozen_string_literal: true

require_relative "06_solution"

describe Day06 do
  let(:input) do
    <<~Str
Time:      7  15   30
Distance:  9  40  200
    Str
  end

  describe ".part_one" do
    subject { described_class.part_one(input) }

    let(:solution) { 288 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { described_class.part_two(input) }

    let(:solution) { 71503 }

    it { is_expected.to eq(solution) }
  end
end
