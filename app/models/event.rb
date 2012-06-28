class Event < ActiveRecord::Base
  attr_accessible :name

  belongs_to  :user
  has_one     :schedule
  has_one     :address
  
  validates :name, presence: true, allow_blank: false
  
  delegate :start_time,   to: :schedule
  delegate :full_address, to: :address
    
  # def nearby_restaurants
  #   Restaurant.all_close_to address
  # end
end