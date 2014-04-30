class AddGamesToFideRatings < ActiveRecord::Migration
  def change
    add_column :fide_ratings, :games, :integer
  end
end
