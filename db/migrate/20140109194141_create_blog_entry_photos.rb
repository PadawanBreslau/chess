class CreateBlogEntryPhotos < ActiveRecord::Migration
  def change
    create_table :blog_entry_photos do |t|
      t.integer :blog_entry_id
      t.timestamps
    end
    add_attachment :blog_entry_photos, :photo
  end
end
