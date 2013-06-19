class Dijkstra::Node
  attr_reader :paths
  attr_accessor :path, :label, :previous_node

  def initialize
    @visited = false
    @paths = []
    @label = Dijkstra::Infinity
  end

  def visit
    @visited = true
  end

  def set_label(visitor, distance_to_this_node)
    if label && (distance_to_this_node < label)
      self.label = distance_to_this_node
      self.previous_node = visitor
    elsif !label
      self.label = distance_to_this_node
      self.previous_node = visitor
    end
  end

  def visited?
    @visited
  end

  def neighbours
    paths.map do |p|
      n = p.left_end == self ? p.right_end : p.left_end
      n.path = p
      n
    end
  end

  def unvisited_neighbours
    neighbours.reject(&:visited?)
  end

  def measure_neighbours_distance
    unvisited_neighbours.each do |node|
      node.set_label(self, dtnn = (label + node.path.distance))
    end
  end

  def reset
    @label = nil
    @visited = false
    @previous_node = nil
    @label = Dijkstra::Infinity
  end
end
