class Schedule < ActiveRecord::Base
  attr_accessible :start_time
  belongs_to :event
  validate  :has_a_valid_start_time?

  private

  def has_a_valid_start_time?
    unless start_time && start_time > Time.now
      errors.add(:start_time, "must have a valid value")
    end
  end
end
