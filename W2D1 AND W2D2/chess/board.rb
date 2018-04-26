
require_relative 'piece'
require 'byebug'
class Board
  # def self.populate
  #   pos = [ ]
  #   (0...board.length).each do |index1|
  #     (0...board.length).each do |index2|
  #       pos << [index1, index2]
  #     end
  #   end
  #
  # end

  def initialize(populate = true)
    fill_board
    

  end


  def fill_board(populate)
    @board = Array.new(8) { Array.new(8) }
    @board = board.map.with_index do |array, index|
      if index == 0 || index == 1 || index == 6 || index == 7
        array.map { |el| Piece.new }
      else
        array
      end
    end
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @board[x][y] = value
  end

  def move_piece(color=nil, start_pos, end_pos)

  end

  def valid_pos?(pos)
  end

  def add_piece(piece, pos)
  end

  def checkmate?(color)
  end

  def in_check?(color)
  end

  def find_king(color)
  end

  def pieces
  end

  def dup
  end

attr_reader :board

end

if __FILE__ == $PROGRAM_NAME
  chess = Board.new
  p chess.board
end
