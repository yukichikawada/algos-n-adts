class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.prev = new_prev
    self.next = new_next
    new_next.prev = new_prev
    new_prev.next = new_next
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return false if (@head.next.nil? && @tail.prev.nil?)
    true
  end

  def get(key)
  end

  def include?(key)
  end

  def append(key, val)
    next_node = Node.new(key, val)
    last_node = @tail.prev
    last_node.next = next_node
    @tail.prev = next_node
  end

  def update(key, val)
    node = @head.next
    until node.next == nil
      if node.key == key
        return node.val = val
      end
      node = node.next
    end
  end

  def remove(key)
    node = @head.next
    until node.next == nil
      if node.key = key
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node
      end
      node = node.next
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
