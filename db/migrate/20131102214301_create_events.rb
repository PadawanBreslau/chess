class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :url
      t.datetime :event_start
      t.datetime :event_finish

      t.timestamps
    end
  end
end
