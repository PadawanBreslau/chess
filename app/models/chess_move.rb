class ChessMove < ActiveRecord::Base

  validates :move_notation, length: {is: 5}
  validates :level, numericality: true

  belongs_to :chess_game
end
