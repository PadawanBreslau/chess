class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
