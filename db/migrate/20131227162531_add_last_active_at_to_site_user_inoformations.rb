class AddLastActiveAtToSiteUserInoformations < ActiveRecord::Migration
  def change
    add_column :site_user_informations, :last_active_at, :datetime
  end
end
