class RemoveCruftFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :street1
    remove_column :events, :street2
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :zip_code
    remove_column :events, :start_time
    remove_column :events, :duration
  end
end
