class CreateRestaurantVotes < ActiveRecord::Migration
  def change
    create_table :restaurant_votes do |t|
      t.belongs_to :invite
      t.belongs_to :restaurant_option

      t.timestamps
    end
  end
end
