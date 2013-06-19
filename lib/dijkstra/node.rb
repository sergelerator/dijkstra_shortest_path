class Dijkstra::Node
  attr_reader :paths
  attr_accessor :path, :label, :previous_node

  def initialize
    @paths = []
    @label = Dijkstra::Infinity
  end

  def set_label(visitor, distance_to_this_node)
    if distance_to_this_node < label
      self.label = distance_to_this_node
      self.previous_node = visitor
    end
  end

  def neighbours
    paths.map do |p|
      n = p.left_end == self ? p.right_end : p.left_end
      n.path = p
      n
    end
  end

  def measure_neighbours_distance
    neighbours.each do |node|
      node.set_label(self, label + node.path.distance)
    end
  end

  def reset
    @previous_node = nil
    @label = Dijkstra::Infinity
  end
end
