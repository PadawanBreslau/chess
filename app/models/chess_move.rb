class ChessMove < ActiveRecord::Base

  validates :move_notation, length: {is: 5}
  validates :level, numericality: true

  belongs_to :chess_game

  def next_move
    game_moves = chess_game.chess_moves
    next_move = game_moves[game_moves.index(self)+1]
    ST_LOG.info  "Found next move: #{next_move.move_notation}"
    next_move
  end
end
