class AddLsIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :ls_id, :string
  end
end
