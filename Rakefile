# frozen_string_literal: true

namespace :solve do
  desc "Run a solution with  rake solve:part_one day=01"
  task :part_one do
    day = ENV["day"]
    require "./2023/#{day}_solution.rb"
    input = File.read("2023/#{day}_input.txt")
    puts Object.const_get("Day#{day}").part_one(input)
  end

  desc "Run a solution with  rake solve:part_two day=01"
  task :part_two do
    day = ENV["day"]
    require "./2023/#{day}_solution.rb"
    input = File.read("2023/#{day}_input.txt")
    puts Object.const_get("Day#{day}").part_two(input)
  end
end
