require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    self.store[(index + start_idx) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    self.store[(index + start_idx) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    val = self[length - 1]
    self.length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if capacity == length
    prev_idx = (length + start_idx) % capacity
    self.length += 1
    store[prev_idx] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    val = self[0]
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity
    self.start_idx = (start_idx - 1) % capacity
    self.length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index > length - 1
  end

  def resize!
    cap = capacity * 2
    n_store = StaticArray.new(cap)
    length.times { |idx| n_store[idx] = self[idx] }
    self.capacity = cap
    self.store = n_store
    self.start_idx = 0
  end
end
