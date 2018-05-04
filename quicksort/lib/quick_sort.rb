class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return array if length < 2

    pivot = QuickSort.partition(array, start, length, &prc)
    left = pivot - start
    right = length - (left + 1)

    QuickSort.sort2!(array, start, left, &prc)
    QuickSort.sort2!(array, pivot + 1, right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    return array if length <= 1
    pivot = start
    pivot_el = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot_el, array[idx]) > 0
        array[idx], array[pivot + 1] = array[pivot + 1], array[idx]
        pivot += 1
      end
    end

    array[start], array[pivot] = array[pivot], array[start]
    pivot
  end
end
