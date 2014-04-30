class AddTitleToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :title, :string
  end
end
