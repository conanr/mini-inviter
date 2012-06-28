class CreateRestaurantOptions < ActiveRecord::Migration
  def change
    create_table :restaurant_options do |t|
      t.belongs_to :event
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
