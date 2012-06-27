class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  has_many :events

  validates :email, presence: true, uniqueness: true

  def self.create_from_oauth_hash(oauth_hash)
    find_or_create_by_email(
      email: oauth_hash["info"]["email"],
      first_name: oauth_hash["info"]["first_name"],
      last_name: oauth_hash["info"]["last_name"])
  end

  def name
    "#{first_name}#{last_name ? ' ' + last_name : ''}"
  end
end