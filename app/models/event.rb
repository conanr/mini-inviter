class Event < ActiveRecord::Base
  attr_accessible :city, :name, :state, :street1, :street2, 
                  :zip_code, :start_time, :duration

  validates :name,    presence: true, allow_blank: false
  validates :street1, presence: true, allow_blank: false
  validates :city,    presence: true, allow_blank: false
  validate  :is_a_valid_state?
  validate  :is_a_valid_zip_code?
  validates :start_time, presence: true
  validate  :is_a_valid_duration?

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
  
  def is_a_valid_duration?
    unless duration && duration > 0 && duration <= 24*60
      errors.add(:duration, "must be greater than 0 hours and no more than 24 hours")
    end
  end
end