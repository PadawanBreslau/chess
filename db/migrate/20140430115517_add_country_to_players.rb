class AddCountryToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :country_code, :string
  end
end
