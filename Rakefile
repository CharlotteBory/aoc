# frozen_string_literal: true

namespace :solve do
  desc "Run a solution"
  task :part_one do
    day = ENV["day"]
    require "./2023/#{day}_solution.rb"
    input = File.read("2023/#{day}_input.txt")
    puts Object.const_get("Day#{day}").part_one(input)
  end
end
