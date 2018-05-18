require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new {|a, b| a <=> b}
  end

  def count
    @store.length
  end

  def extract

  end

  def peek

  end

  def push(val)
    # @store.push(val)
    # finish heapify
  end

  public
  def self.child_indices(len, parent_index)
    res = []
    if (parent_index * 2) + 1 < len
      res << (parent_index * 2) + 1
    end
    if (parent_index * 2) + 2 < len
      res << (parent_index * 2) + 2
    end
    res
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    return (child_index / 2) - 1 if child_index.even?
    (child_index / 2)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    indices = self.child_indices(len, parent_idx)
    # debugger
    return if indices.empty?

    left = [array[indices[0]], indices[0]]

    if indices[1]
      right = [array[indices[1]], indices[1]]
      left[0] > right[0] ? lesser = right : lesser = left
    else
      lesser = left
    end

    if array[parent_idx] > lesser[0]
      array[parent_idx], array[lesser[1]] = array[lesser[1]], array[parent_idx]
      self.heapify_down(array, lesser[1], array.length, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
