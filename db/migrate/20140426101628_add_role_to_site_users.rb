class AddRoleToSiteUsers < ActiveRecord::Migration
  def change
    add_column :site_users, :role, :string
  end
end
