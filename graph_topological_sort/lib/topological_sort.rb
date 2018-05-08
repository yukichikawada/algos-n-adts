require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  sorted = []
  # keep track of vertex in_edges count so that
  # it doesnt get prematurely pushed into queue
  count = {}

  # find started vertexes
  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_edges.empty?
    count[vertex] = vertex.in_edges.count
  end

  until queue.empty?
    vertex = queue.shift
    sorted << vertex
    vertex.out_edges.each do |edge|
      vert = edge.to_vertex
      count[vert] -= 1
      queue.push(vert) if count[vert] == 0
    end
  end

  sorted.count == vertices.count ? sorted : []
end
