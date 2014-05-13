class Round < ActiveRecord::Base

  has_many :games
  has_many :white_players, :through => :games, primary_key: :white_player_id,  foreign_key: :id
  has_many :black_players, :through => :games, primary_key: :black_player_id,  foreign_key: :id
  belongs_to :tournament

def players
  return [] if games.empty?
  self.white_players + self.black_players
end

end
