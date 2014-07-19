class Round < ActiveRecord::Base

  has_many :chess_games
  has_many :white_players, :through => :chess_games, primary_key: :white_player_id,  foreign_key: :id
  has_many :black_players, :through => :chess_games, primary_key: :black_player_id,  foreign_key: :id
  belongs_to :tournament

def players
  return [] if chess_games.empty?
  self.white_players + self.black_players
end

end
