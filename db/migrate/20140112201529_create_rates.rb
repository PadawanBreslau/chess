class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :likes, :null => false, :default => 0
      t.integer :dislikes, :null => false, :default => 0
      t.float :general_rate, :null => false, :default => 0.0
      t.integer :rateable_id
      t.string :rateable_type
    end
  end
end
