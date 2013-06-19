class Dijkstra::Graph
  attr_reader :paths, :nodes

  def initialize
    @paths = []
  end

  def add_node(node)
    (@nodes ||= []) << node
  end

  def link_nodes(a, b, distance)
    paths.push (p = Dijkstra::Path.new(a, b, distance))
    a.paths << p
    b.paths << p
  end

  def clear
    @nodes, @paths = [], []
  end

  def reset
    nodes.each(&:reset)
  end

  def label_everything_from(source)
    reset
    source.label = 0
    ordered_set = nodes.clone

    while !ordered_set.empty?
      ordered_set.sort_by! { |e| e.label }
      next_node = ordered_set.shift
      next_node.measure_neighbours_distance
    end
  end

  def shortest_path(source, destination)
    label_everything_from(source)
    (path = []) << destination
    path << path.last.previous_node until path.last.previous_node.nil?
    path.reverse
  end
end
