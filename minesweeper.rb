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
  end

  def get_tile(coord)
    self.board[coord[0]][coord[1]]
  end

  def legal_neighbors(coord)
    possible_neighbors = [[1,1], [1,-1], [1,0], [0,1],                            [0,-1], [-1, 1], [-1, -1], [-1, 0]]
    result = []
    possible_neighbors.each do |coor|
      if (0..9).include?(coord[0] + coor[0]) && (0..9).include?(coord[1] + coor[1])
        result << coor
      end
    end
    result
  end

  def search_neighbors(tile)
    coords = tile.coordinates
    legals = legal_neighbors(coords)
    count = 0
    legals.each do |tile|
      if tile.mined
        count += 1
      end
    end
    tile.count = count
  end

  def check_tile(coord)
    tile = get_tile(coord)

    return :mined if tile.mined

    tile.state = tile.count.to_s
    #
    if tile.count == 0
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

  @@num_bombs = 0

  def initialize(coords)
    @coordinates = coords
    @state = "*"
  end

end


