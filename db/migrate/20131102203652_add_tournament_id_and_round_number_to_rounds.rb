class AddTournamentIdAndRoundNumberToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :tournament_id, :integer
    add_column :rounds, :round_number, :integer
  end
end
