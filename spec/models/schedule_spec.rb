require 'spec_helper'

describe Schedule do
  context "using invalid data" do
    it 'rejects blank times' do
      event_schedule = Schedule.create
      event_schedule.valid?.should be_false
    end

    it 'rejects times in the past' do
      event_schedule = Schedule.create start_time: 3.days.ago
      event_schedule.valid?.should be_false
    end
  end

  context "using valid data" do
    it 'accepts times in the future' do
      valid_time = 3.days.from_now
      event_schedule = Schedule.create start_time: valid_time
      event_schedule.valid?.should be_true
      event_schedule.start_time.should == valid_time
    end
  end
end
