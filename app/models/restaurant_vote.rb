class RestaurantVote < ActiveRecord::Base
  attr_accessible :invite_id, :restaurant_option_id
  
  belongs_to :restaurant_option
  belongs_to :invite
end
