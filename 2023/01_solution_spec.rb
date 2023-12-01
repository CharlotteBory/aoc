# frozen_string_literal: true

require_relative "01_solution"

describe Day01 do
  describe ".part_one" do
    subject { Day01.part_one(input) }

    let(:input) do
      <<-Str
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
      Str
    end

    let(:solution) { 142 }

    it { is_expected.to eq(solution) }
  end

  describe ".part_two" do
    subject { Day01.part_two(input) }

    let(:input) do
      <<-Str
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      Str
    end

    let(:solution) { 281 }

    it { is_expected.to eq(solution) }
  end
end
