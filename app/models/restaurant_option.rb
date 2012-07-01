class RestaurantOption < ActiveRecord::Base
  attr_accessible :event_id, :restaurant_id
  
  belongs_to  :event
  belongs_to  :restaurant
  has_many    :restaurant_votes

  delegate    :name, to: :restaurant
  
  def vote_count
    restaurant_votes.count
  end
end
