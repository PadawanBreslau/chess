class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.integer :chess_move_id, null: false
      t.integer :site_user_id, null: false
      t.string :comment
      t.string :type
      t.timestamps
    end
  end
end
