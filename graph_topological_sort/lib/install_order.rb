# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  vertices = []
  max_id = arr.flatten.max

  # initialize all vertices as required for Edge.new(v1, v2)
  # don't mind 0 ~ eliminates shifting idx when creating Edges
  (0..max_id).each do |value|
    vertices << Vertex.new(value)
  end

  # set each Vertex in_edges & out_edges by initializing Edge
  arr.each do |el|
    Edge.new(vertices[el[0]], vertices[el[1]])
  end

  # sort, extract values, and reverse order bc dependency means LIFO
  topological_sort(vertices).map(&:value).reverse!
end
