class AddAvgRatingToResults < ActiveRecord::Migration
  def change
    add_column :results, :avg_rating, :float
  end
end
