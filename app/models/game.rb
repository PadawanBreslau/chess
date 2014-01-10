class Game < ActiveRecord::Base

RESULTS = [nil, "1-0","1/2","0-1", "*"]

validates :white_player, presence: true
validates :black_player, presence: true
validates :result, presence: true, inclusion: (1..RESULTS.length)

has_one :white_player, class_name: "Player", primary_key: :white_player_id,  foreign_key: :id
has_one :black_player, class_name: "Player", primary_key: :black_player_id,  foreign_key: :id

belongs_to :round

def chess_result
  RESULTS[self.result] || "?"
end


end
