class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :player_id, :null => false
      t.integer :tournament_id, :null => false
      t.integer :games_count, :null => false, :default => 0
      t.float :points, :null => false, :default => 0.0
      t.float :bucholtz, :null => false, :default => 0.0
      t.float :mini_bucholtz, :null => false, :default => 0.0
      t.float :berger, :null => false, :default => 0.0
      t.float :progress, :null => false, :default => 0.0
    end
  end
end
