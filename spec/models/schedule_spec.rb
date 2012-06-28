require 'spec_helper'

describe Schedule do
  it 'requires a vaid start time' do
    
    event_schedule = Schedule.create
    event_schedule.valid?.should be_false

    event_schedule.update_attribute :start_time, Time.parse("Jan 01, 2009 12:00PM")
    event_schedule.valid?.should be_false
  
    event_schedule.update_attribute :start_time, Time.parse("May 30, 2013 12:00PM")
    event_schedule.valid?.should be_true
    event_schedule.start_time.should == Time.parse("May 30, 2013 12:00PM")
  end
end
