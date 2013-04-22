class Minesweeper
end


class Board
  attr_accessor :board
  def initialize(dimension = 9)
    @board = Array.new(dimension) {Array.new(dimension)}
    dimension.times do |row|
      dimension.times do |item|
        @board[row][item] = '*'
      end
    end
  end

  def display
    @board.each do |row|
      p row
    end
  end


end