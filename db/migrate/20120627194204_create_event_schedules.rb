class CreateEventSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.integer :event_id

      t.timestamps
    end
  end
end
