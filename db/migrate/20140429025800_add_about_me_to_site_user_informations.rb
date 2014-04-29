class AddAboutMeToSiteUserInformations < ActiveRecord::Migration
  def change
    add_column :site_user_informations, :about_me, :text
  end
end
