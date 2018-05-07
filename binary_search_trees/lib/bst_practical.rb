require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  bst.root = tree_node
  arr = bst.in_order_traversal
  bst.find(arr[arr.length - k])
end
