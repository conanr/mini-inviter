class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name
  validates :name, presence: true
  validates :address, presence: true
end
