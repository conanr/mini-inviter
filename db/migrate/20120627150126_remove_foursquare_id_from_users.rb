class RemoveFoursquareIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :foursquare_id
  end
end
