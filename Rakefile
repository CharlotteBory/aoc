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

namespace :generate do
  desc "Create files for the day from template"
  task :day do
    day = ENV["day"]
    sh <<-Command
    cp 2023/00_solution.rb 2023/#{day}_solution.rb
    cp 2023/00_input.txt 2023/#{day}_input.txt
    cp 2023/00_solution_spec.rb 2023/#{day}_solution_spec.rb
    sed -i "" "s/00/#{day}/g" 2023/#{day}_solution.rb 2023/#{day}_solution_spec.rb
    Command
  end
end
