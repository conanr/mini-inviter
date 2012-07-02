class Event < ActiveRecord::Base
  attr_accessible :name

  belongs_to  :user
  has_one     :schedule, :dependent => :destroy
  has_one     :address, :dependent => :destroy
  has_many    :restaurant_options, :dependent => :destroy
  has_many    :invites, :dependent => :destroy

  validates :name, presence: true, allow_blank: false

  delegate :start_time,   to: :schedule
  delegate :full_address, to: :address

  def nearby_restaurants
    Restaurant.all_close_to full_address
  end
end