class AddSiteUserInformationIdToSiteUser < ActiveRecord::Migration
  def change
    add_column :site_users, :site_user_information_id, :integer
  end
end
