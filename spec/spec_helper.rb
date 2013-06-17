require "simplecov"

SimpleCov.start do
  minimum_coverage 90
end

RSpec.configure do |c|
  c.color = true
end

require "./lib/dijkstra"
