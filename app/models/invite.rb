class Invite < ActiveRecord::Base
  attr_accessible :contact_id, :event_id
  
  belongs_to  :contact
  belongs_to  :event
  has_one     :restaurant_vote
end