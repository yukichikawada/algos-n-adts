class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2 => [[2],[1,1]], 3 => [[1,2],[2,1],[1,1,1],[3]]}
    @maze_cache = []
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    result = blair_nums(n-1) + blair_nums(n-2) + (2 * (n - 1) - 1)
    @blair_cache[n] = result
    result
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    # ways = [[1], [[1, 1], [2]]]
    #
    # return ways[0...n] if n < 3
    #
    # (3..n).each do |idx|
    #   new_way_set = []
    #
    #   (1..3).each do |step1|
    #     ways[idx - step1].each do |way|
    #       new_way = [step1]
    #
    #       ways.each do |step|
    #         new_way << step
    #       end
    #
    #       new_way_set << new_way
    #     end
    #   end
    #
    #   ways << new_way_set
    # end
    #
    # ways
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    result = []
    (1..3).each do |i|
      result.concat(frog_hops_top_down_helper(n - i).map {|j| j + [i]})
    end
    @frog_cache[n] = result
    result
  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)
    array = knapsack_table(weights, values, capacity)
    array.last.last
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    n = weights.length
    array = Array.new(capacity + 1) { Array.new(n, 0) }

    (1..capacity).each do |j|
      (0...n).each do |i|
        if weights[i] > j
          array[j][i] = array[j][i - 1]
        elsif i == 0
          array[j][i] = values[i]
        else
          prev_val = array[j][i - 1]
          array[j][i] = [prev_val, array[j - weights[i]][i - 1] + values[i]].max
        end
      end
    end

    array
  end

  def maze_solver(maze, start_pos, end_pos)
    @maze_cache[start_pos] = nil
    queue = [start_pos]

    until queue.empty?
      current = queue.pop
      break if current == end_pos

      get_moves(maze, current).each do |move|
        @maze_cache[move] = current
        queue << move
      end
    end

    @maze_cache.include?(end_pos) ? path_from_cache(end_pos) : nil
  end

  def get_moves(maze, pos)
    x, y = pos
    moves = []
    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]

    directions.each do |new_x, new_y|
      next_pos = [x + new_x, y + new_y]

      if is_valid_pos?(maze, next_pos)
        moves << next_pos unless @maze_cache.includes?(next_pos)
      end
    end

    moves
  end

  def is_valid_pos?(maze, next_pos)
    x, y = next_pos
    x >= 0 && y >= 0 && x < maze.length && y < maze.first.length && maze[x][y] != "X"
  end

  def path_from_cache(end_pos)
    path = []
    current = end_pos

    while current
      path.unshift(current)
      current = @maze_cache[current]
    end

    path
  end
end
