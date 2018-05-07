# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      insert_recursive(@root, value)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    case value <=> tree_node.value
    when -1
      find(value, tree_node.left)
    when 0
      tree_node
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    return @root = nil if @root.value == value
    node = find(value)
    parent = find_parent(value, @root)
    if node.left.nil? && node.right.nil?
      patch_parent(parent, nil, value)
    elsif node.left && node.right.nil?
      patch_parent(parent, node.left, value)
    elsif node.left.nil? && node.right
      patch_parent(parent, node.right, value)
    elsif node.left && node.right
      max_node = maximum(node.left)
      max_node_parent = find_parent(max_node.value)
      patch_parent(parent, max_node, value)
      if max_node.left
        max_child = max_node.left
        patch_parent(max_node_parent, max_child, max_node.value)
      else
        max_child = max_node.right
        patch_parent(max_node_parent, max_child, max_node.value)
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    until tree_node.right.nil?
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
    if tree_node == nil
      return -1
    else
      return [depth(tree_node.left), depth(tree_node.right)].max + 1
    end
  end

  def is_balanced?(tree_node = @root)
    depth(@root.left) == depth(@root.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    left_children = self.in_order_traversal(tree_node.left)
    right_children = self.in_order_traversal(tree_node.right)
    left_children + [tree_node.value] + right_children
  end


  private
  # optional helper methods go here:

  def insert_recursive(node, value)
    if node.nil?
      node = BSTNode.new(value)
    elsif node.value > value
      node.left = insert_recursive(node.left, value)
    else
      node.right = insert_recursive(node.right, value)
    end
    node
  end

  def find_parent(value, node = @root)
    return node if node.left.value == value || node.right.value == value
    if node.left.value == node.value || node.right.value == node.value
      node
    elsif node.value > value
      find_parent(value, node.left)
    else
      find_parent(value, node.right)
    end
  end

  def patch_parent(parent, new_child, value)
    if parent.left.value == value
      parent.left = new_child
    elsif parent.right.value == value
      parent.right = new_child
    end
  end

end
