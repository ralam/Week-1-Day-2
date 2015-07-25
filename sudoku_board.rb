require_relative 'tile'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    rows = File.readlines(file).map(&:chomp)
    rows.map! { |row| row.split('') }
    rows.each { |row| row.map!(&:to_i) }
  end
end
