class AddFenBeforeAndFenAfterToChessMoves < ActiveRecord::Migration
  def change
    add_column :chess_moves, :fen_before, :string
    add_column :chess_moves, :fen_after, :string
  end
end
