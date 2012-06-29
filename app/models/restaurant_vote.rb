class RestaurantVote < ActiveRecord::Base
  attr_accessible :invite_id, :restaurant_option_id
  
  belongs_to :restaurant_option
  belongs_to :invite
  
  validates :invite_id, uniqueness: true
end
