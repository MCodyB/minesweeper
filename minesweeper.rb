class Minesweeper
end


class Board
  attr_accessor :board
  def initialize(dimension = 9)
    @board = Array.new(dimension) {Array.new(dimension)}
    dimension.times do |x|
      dimension.times do |y|
        @board[x][y] = Tile.new([x, y])
      end
    end
    @board.flatten.sample(10).each{|tile| tile.mined = true}
    set_board_count
  end

  def set_board_count
    @board.size.times do |x|
      @board.size.times do |y|
        set_count([x,y])
      end
    end
  end



  def get_tile(coord)
    self.board[coord[0]][coord[1]]
  end

  def legal_neighbors(coord)
    possible_neighbors = [[1,1], [1,-1], [1,0], [0,1],                            [0,-1], [-1, 1], [-1, -1], [-1, 0]]
    result = []
    possible_neighbors.each do |coor|
      x_coor = coord[0] + coor[0]
      y_coor = coord[1] + coor[1]
      if (0...9).include?(x_coor) && (0...9).include?(y_coor)
        result << [x_coor, y_coor]
      end
    end
    result
  end

  def set_count(coord)
    tile = get_tile(coord)
    if tile.mined
      count = nil
    else
      legals = legal_neighbors(coord)
      p legals
      count = 0
      legals.each do |nb|
        tl = get_tile(nb)
        count += 1 if tl.mined
      end
    end
    tile.count = count
  end

  def reveal_bombs
    @board.flatten.each{|piece| p piece.coordinates if piece.mined}
  end

  def check_tile(coord)
    tile = get_tile(coord)

    if tile.mined
      return "You Lose"

    elsif tile.count > 0
      tile.state = tile.count.to_s
      return

    elsif tile.count == 0
      tile.state = "-"
      legal_neighbors(tile.coordinates).each do |pos|
        check_tile(pos)
      end
    end
  end

  def display
    result = []
    @board.each do |row|
      temp = []
      row.each do |tile|
        temp << tile.state
      end
      result << temp
    end
    p result
  end

end


class Tile
  attr_accessor :mined, :coordinates, :count, :state, :flag

  def initialize(coords)
    @coordinates = coords
    @state = "*"
  end

end


