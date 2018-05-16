require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
  end

  # O(1)
  def []=(index, val)
  end

  # O(1)
  def pop
    check_index(@length)
  end

  # O(1) ammortized
  def push(val)
  end

  # O(1)
  def shift
    check_index(@length)
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index > @length - 1
  end

  def resize!
  end
end
