class AddCountryToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :country, :string
  end
end
