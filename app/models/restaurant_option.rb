class RestaurantOption < ActiveRecord::Base
  attr_accessible :event_id, :restaurant_id
  
  belongs_to :event
  belongs_to :restaurant
end
