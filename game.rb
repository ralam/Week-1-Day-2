require 'byebug'
require_relative 'board'
class Game

  def initialize
    @board = Board.new
    @marks = [:X, :O]
    @current_player = 0
  end

  def run
    display_board
    until board.over?
      take_turn
      switch_players
    end
    display_winner
  end

  private

  def display_board
    board.render
  end

  def take_turn
    prompt
    col = parse
    board.drop_disc(col, marks[current_player])
  end

  def display_winner
    puts "#{board.winner.to_s} is the winner"
  end

  def switch_players
    self.current_player = 1 - current_player
    board.render
  end

  def prompt
    puts "Pick a column to drop your disc into"
  end

  def parse
    col = 0
    until valid_input?(col - 1)
      print ">"
      col = gets.chomp.to_i
    end
    col - 1
  end

  def valid_input?(col)
    !col.nil? && (0..6).include?(col) && !board.grid_by_cols[col].last
  end

  private

  attr_reader :board, :marks
  attr_accessor :current_player

end
