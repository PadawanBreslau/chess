class AddRoundIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :round_id, :integer
  end
end
