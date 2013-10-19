class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :middlename
      t.string :surname
      t.integer :fide_id
      t.date :date_of_birth
      t.integer :site_user_id
      t.integer :player_photo_id

      t.timestamps
    end
  end
end
