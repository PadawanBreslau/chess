class CreateSiteUsersRates < ActiveRecord::Migration
  def change
    create_table :site_users_rates do |t|
      t.integer :site_user_id, :null => false
      t.integer :rate_id, :null => false
      t.string :rate_action
    end
  end
end
