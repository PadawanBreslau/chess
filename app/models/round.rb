class Round < ActiveRecord::Base

  has_many :chess_games
  has_many :white_players, :through => :chess_games, primary_key: :white_player_id,  foreign_key: :id
  has_many :black_players, :through => :chess_games, primary_key: :black_player_id,  foreign_key: :id
  belongs_to :tournament

  validates :round_number, uniqueness: {scope: :tournament_id}, numericality: true, :inclusion => { :in => 1..999, :message => "The round_number must be between 1 and 999" }

def players
  return [] if chess_games.empty?
  self.white_players + self.black_players
end

end
