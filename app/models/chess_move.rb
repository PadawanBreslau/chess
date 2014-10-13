class ChessMove < ActiveRecord::Base
  SHORT_CASTLES = ["e1-g1","e8-g8"]
  LONG_CASTLES = ["e1-c1", "e8-c8"]
  CASTLES = SHORT_CASTLES + LONG_CASTLES

  validates :move_notation, length: {is: 5}
  validates :level, numericality: true

  belongs_to :chess_game

  def variations
    ["aaa", "bbb", "ccc"]
  end

  def next_move
    game_moves = chess_game.chess_moves
    next_move = game_moves[game_moves.index(self)+1]
    ST_LOG.info  "Found next move: #{next_move.move_notation}"
    next_move
  end

  def get_move_string
    if move_notation == "e1-c1"
      [move_notation, "a1-d1"]
    elsif move_notation == "e1-g1"
      [move_notation, "h1-f1"]
    elsif move_notation == "e8-c8"
      [move_notation, "a8-d8"]
    elsif move_notation == "e8-g8"
      [move_notation, "h8-f8"]
    else
      move_notation
    end
  end

  def get_move_output
    if is_short_castle?
      'o-o'
    elsif is_long_castle?
      'o-o-o'
    else
      piece + move_notation
    end
  end

  def is_short_castle?
    SHORT_CASTLES.include?(move_notation) && piece == 'K'
  end

  def is_long_castle?
    LONG_CASTLES.include?(move_notation) && piece == 'K'
  end
end
