class FideRatings < ActiveRecord::Migration
  def change
    create_table :fide_ratings do |t|
      t.integer :rating
      t.integer :fide_id
      t.integer :year
      t.integer :month
    end
  end
end
