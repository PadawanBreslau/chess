class CreateChessGames < ActiveRecord::Migration
  def change
    create_table :chess_games do |t|
    	t.datetime :date
    	t.integer :white_player_id
    	t.integer :black_player_id
    	t.integer :result
    	t.string  :eco

    	t.timestamps
    end
  end
end
