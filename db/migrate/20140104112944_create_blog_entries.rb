class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.integer :site_user_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
