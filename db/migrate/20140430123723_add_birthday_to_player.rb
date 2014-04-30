class AddBirthdayToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :birthday, :integer
  end
end
