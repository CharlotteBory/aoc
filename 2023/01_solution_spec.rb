# frozen_string_literal: true

require_relative "01_solution"

describe Day01 do
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
