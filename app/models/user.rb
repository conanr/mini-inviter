class User < ActiveRecord::Base
  attr_accessible :email, :foursquare_id, :first_name, :last_name

  has_many :events

  validates :email, presence: true, uniqueness: true
  validates :foursquare_id, presence: true, uniqueness: true

  def self.create_from_oauth_hash(oauth_hash)
    find_or_create_by_foursquare_id(foursquare_id: oauth_hash["uid"],
      first_name: oauth_hash["info"]["first_name"],
      last_name: oauth_hash["info"]["last_name"],
      email: oauth_hash["info"]["email"])
  end

  def name
    "#{first_name}#{last_name ? ' ' + last_name : ''}"
  end
end