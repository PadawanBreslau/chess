class CreateSiteUserInformations < ActiveRecord::Migration
  def change
    create_table :site_user_informations do |t|
      t.integer :site_user_id
      t.string  :name
      t.string  :surname
      t.string  :nick
      t.date    :date_of_birth
      t.float   :reputation, default: 0.0
      t.string  :country_code

      t.timestamps
    end
  end
end
