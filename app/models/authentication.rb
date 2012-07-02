class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid

  belongs_to :user

  validates :provider,  presence: true, allow_blank: false
  validates :uid,       presence: true, allow_blank: false
  validates_uniqueness_of :uid, scope: :provider

  def self.from_oauth_hash(user, oauth_hash)
    user.authentications.find_or_create_by_provider_and_uid(
      provider: oauth_hash["provider"],
      uid:      oauth_hash["uid"],
      token:    oauth_hash["credentials"]["token"])
  end
end
