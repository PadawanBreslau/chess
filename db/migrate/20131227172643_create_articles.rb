class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :site_user_id
      t.string :title
      t.string :lead
      t.string :summary
      t.text :content
      t.timestamps
    end
  end
end
