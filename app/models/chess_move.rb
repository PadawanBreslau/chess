class ChessMove < ActiveRecord::Base

  CASTLES = ["e1-c1", "e1-g1", "e8-c8", "e1-g1"]

  validates :move_notation, length: {is: 5}
  validates :level, numericality: true

  belongs_to :chess_game

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

end
