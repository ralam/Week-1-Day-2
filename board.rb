require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) {Array.new(7)}
  end

  def [](row, col)
    @grid[row][col]
  end

  def drop_disc(col_idx, disc)
    col = grid_by_cols[col_idx]
    row_idx = find_first_space_in_column(col)
    grid[row_idx][col_idx] = disc
  end

  def over?
    !!winner
  end

  def winner
    row_winner || col_winner || diag_winner || nil
  end

  def render
    col_header = (1..7).reduce('') { |header, idx| "#{header}  #{idx}  " }
    puts col_header
    @grid.reverse.each do |row|
      puts row_to_str(row)
    end
  end

  def grid_by_cols
    grid.transpose
  end

  private

  def row_to_str(row)
    row.reduce("") {|memo, cell| "#{memo} #{cell_to_str(cell)} "}
  end

  def cell_to_str(cell)
    "[#{cell.nil? ? ' ' : cell.to_s}]"
  end

  def find_first_space_in_column(col)
    col.each_with_index.find_index { |cell, idx| cell.nil? }
  end

  def row_winner
    line_winner(grid)
  end

  def line_winner(lines)
    lines.each { |line| return slice_winner(line) if slice_winner(line) }
    return nil
  end

  def col_winner
    line_winner(grid_by_cols)
  end

  def diag_winner
    line_winner(diagonals)
  end

  def slice_winner(line)
    line.each_cons(4) do |slice|
      return slice[0] if !slice.include?(nil) && slice.min == slice.max
    end
  end


  def move_up_left(pos)
    [pos.first + 1, pos.last - 1]
  end

  def move_up_right(pos)
    [pos.first + 1, pos.last + 1]
  end

  def diagonals
    res = []
    #up right
    (0..grid.length/2 - 1).each do |row_idx|
      (0..grid[0].length/2).each do |col_idx|
        pos = [row_idx, col_idx]
        slice = [self[*pos]]
        3.times do ||
          pos = move_up_right(pos)
          slice << self[*pos]
        end
        res << slice
      end
    end
      #up left
    (0..grid.length/2 - 1).each do |row_idx|
      (grid[0].length/2..grid[0].length - 1).each do |col_idx|
        pos = [row_idx, col_idx]
        slice = [self[*pos]]
        3.times do ||
          pos = move_up_left(pos)
          slice << self[*pos]
        end
        res << slice
      end
    end
    res
  end
end
