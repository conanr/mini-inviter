class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  has_many :authentications, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :contacts, :dependent => :destroy

  validates :email, presence: true, uniqueness: true

  def self.from_oauth_hash(oauth_hash)
    user = find_or_create_by_email(
      email:      oauth_hash["info"]["email"],
      first_name: oauth_hash["info"]["first_name"],
      last_name:  oauth_hash["info"]["last_name"])
    Authentication.from_oauth_hash(user, oauth_hash)
    user
  end

  def name
    "#{first_name}#{last_name ? ' ' + last_name : ''}"
  end
end