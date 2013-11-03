class AddEventIdToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :event_id, :integer
  end
end
