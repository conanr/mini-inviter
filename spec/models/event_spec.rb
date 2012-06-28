require 'spec_helper'

describe Event do
  let!(:user) { FactoryGirl.create :user }
  
  it 'requires a non-blank name' do
    event = Event.create
    event.valid?.should be_false
    
    event.update_attribute :name, "    "
    event.valid?.should be_false
  
    event.update_attribute :name, "Eric's Birthday Party"
    event.valid?.should be_true
    event.name.should == "Eric's Birthday Party"
  end
  
  describe '#start_time' do
    it 'displays the start time'
  end

  describe '#full_address' do
    it 'displays the full address'
  end
  
  # describe '#nearby_restaurants' do
  #   let!(:event)      { Event.create event_attributes  }
  #   let!(:restaurant) { FactoryGirl.create :restaurant }
  # 
  #   it 'returns a collection of nearby restaurants' do
  #     event.nearby_restaurants.include?(restaurant).should be_true
  #   end
  # end
end