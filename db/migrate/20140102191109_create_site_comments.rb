class CreateSiteComments < ActiveRecord::Migration
  def change
    create_table :site_comments do |t|
      t.integer :site_user_id, :null => false
      t.string :content, :null => false
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps
    end
  end
end
