class CreateTournament < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :tournament_name
      t.datetime :tournament_start
      t.datetime :tournament_finish
      t.integer :round_number
      t.boolean :is_finished
      t.string :place
      t.string :url
      t.string :external_transmition_url

      t.timestamps
    end
  end
end
