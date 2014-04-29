class AddRatingToSiteUserInformations < ActiveRecord::Migration
  def change
    add_column :site_user_informations, :rating, :integer
  end
end
