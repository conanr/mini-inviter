class AddStartTimeAndDurationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :datetime
    add_column :events, :duration, :integer
  end
end
