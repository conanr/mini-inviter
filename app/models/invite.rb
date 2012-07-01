class Invite < ActiveRecord::Base
  attr_accessible :contact_id, :event_id
  
  belongs_to  :contact
  belongs_to  :event
  has_one     :restaurant_vote
  
  delegate    :email, to: :contact
  delegate    :name, to: :contact
  
  after_create  :send_invite

  private
  
  def send_invite
    EventMailer.create_invite(self).deliver
  end
end
