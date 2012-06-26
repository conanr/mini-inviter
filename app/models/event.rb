class Event < ActiveRecord::Base
  attr_accessible :city, :name, :state, :street1, :street2, :zip_code
  
  validates :name,    presence: true, allow_blank: false
  validates :street1, presence: true, allow_blank: false
  validates :city,    presence: true, allow_blank: false
  validate  :is_a_valid_state?
  validate  :is_a_valid_zip_code?
  
  def nearby_restaurants
    Restaurant.all_close_to address
  end
  
  def address
    [street1, street2, city, state].join(", ").gsub(", ,", ",") + " #{zip_code}"
  end
  
  private

  def is_a_valid_state? 
    unless US_STATE_ABBREVIATIONS.include?(state)
      errors.add(:state, "must be a valid US state")
    end
  end
  
  def is_a_valid_zip_code?
    unless zip_code && zip_code[/(^\d{5}$)|(^\d{5}-\d{4}$)/]
      errors.add(:zip_code, "must be a valid US zip code")
    end
  end
end
