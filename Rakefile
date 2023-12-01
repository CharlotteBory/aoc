# frozen_string_literal: true

namespace :solve do
  desc "Run a solution"
  task :part_one do
    day = ENV["day"]
    require "./2023/#{day}_solution.rb"
    input = File.read("2023/#{day}_input.txt")
    puts Day01.part_one(input)
  end
end
