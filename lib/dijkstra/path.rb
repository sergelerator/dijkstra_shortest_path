class Dijkstra::Path
  attr_accessor :left_end, :right_end, :distance

  def initialize(left_end, right_end, distance)
    @left_end = left_end
    @right_end = right_end
    @distance = distance
  end
end
