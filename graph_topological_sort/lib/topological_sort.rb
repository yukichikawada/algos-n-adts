require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []

  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue.push(vertex)
    end
  end
  

  sorted
end
