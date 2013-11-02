class Round < ActiveRecord::Base

	has_many :games
	has_many :white_players, :through => :games, primary_key: :white_player_id,  foreign_key: :id
	has_many :black_players, :through => :games, primary_key: :black_player_id,  foreign_key: :id



def players
	self.white_players.concat(self.black_players)
end

end