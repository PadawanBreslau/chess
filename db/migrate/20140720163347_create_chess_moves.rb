class CreateChessMoves < ActiveRecord::Migration
  def change
    create_table :chess_moves do |t|
      t.string :move_number
      t.string :move_notation

      t.integer :level, default: 0
      t.integer :previous_move

      t.integer :chess_game_id

      t.timestamps
    end
  end
end
