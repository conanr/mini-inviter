class Contact < ActiveRecord::Base
  attr_accessible :email, :name

  belongs_to :user

  validates :name, presence: true
  validate :has_valid_email_address?

  def has_valid_email_address?
    unless email && email[EMAIL_VALIDATION_REGEX]
      errors.add(:email, "must have a valid email address")
    end
  end
end
