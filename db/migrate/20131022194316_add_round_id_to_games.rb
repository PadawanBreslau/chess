class AddRoundIdToGames < ActiveRecord::Migration
  def change
    add_column :chess_games, :round_id, :integer
  end
end
