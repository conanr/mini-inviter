class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid
  
  validates :provider,  presence: true, allow_blank: false
  validates :uid,       presence: true, allow_blank: false
  validate  :uid_does_not_exist_for_provider?
  
  private
  
  def uid_does_not_exist_for_provider?
    if Authentication.find_by_uid_and_provider(uid, provider)
      errors.add(:provider, "already exists for #{provider}")
    end
  end
end
