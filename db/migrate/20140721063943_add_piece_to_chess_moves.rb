class AddPieceToChessMoves < ActiveRecord::Migration
  def change
    add_column :chess_moves, :piece, :string
  end
end
