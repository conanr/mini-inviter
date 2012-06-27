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
  
  # let!(:event_attributes) { { name:       "Eric's Birthday Party", 
  #                             street1:    "1445 New York Ave. NW",
  #                             street2:    "Suite 201",
  #                             city:       "Washington",
  #                             state:      "DC",
  #                             zip_code:   "20005",
  #                             start_time: Time.parse("May 30, 2013 12:00PM") } }
  # 
  # it 'requires a non-blank name' do
  #   event_attributes[:name] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :name, "    "
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :name, "Eric's Birthday Party"
  #   event.valid?.should be_true
  #   event.name.should == "Eric's Birthday Party"
  # end
  # 
  # it 'requires a non-blank primary street address' do
  #   event_attributes[:street1] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :street1, "    "
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :street1, "1445 New York Ave. NW"
  #   event.valid?.should be_true
  #   event.street1.should == "1445 New York Ave. NW"
  # end
  # 
  # it 'may have a secondary street address' do
  #   event = Event.create event_attributes
  #   event.street2.should == "Suite 201"
  # end
  # 
  # it 'requires a non-blank city' do
  #   event_attributes[:city] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :city, "    "
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :city, "Washington"
  #   event.valid?.should be_true
  #   event.city.should == "Washington"
  # end
  # 
  # it 'requires a valid state abbreviation' do
  #   event_attributes[:state] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :state, "    "
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :state, "ZZ"
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :state, "DC"
  #   event.valid?.should be_true
  #   event.state.should == "DC"
  # end
  # 
  # it 'requires a valid zip code' do
  #   event_attributes[:zip_code] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :zip_code, "    "
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :zip_code, "ABCDE"
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :zip_code, "2000"
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :zip_code, "20005"
  #   event.valid?.should be_true
  #   
  #   event.update_attribute :zip_code, "20005-123"
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :zip_code, "20005-1234"
  #   event.valid?.should be_true
  #   event.zip_code.should == "20005-1234"
  # end
  # 
  # it 'requires a vaid start time' do
  #   event_attributes[:start_time] = nil
  #   event = Event.create event_attributes
  #   event.valid?.should be_false
  # 
  #   event.update_attribute :start_time, Time.parse("Jan 01, 2009 12:00PM")
  #   event.valid?.should be_false
  #   
  #   event.update_attribute :start_time, Time.parse("May 30, 2013 12:00PM")
  #   event.valid?.should be_true
  #   event.start_time.should == Time.parse("May 30, 2013 12:00PM")
  # end
  # 
  # describe '#address' do
  #   let!(:event)      { Event.create event_attributes }
  #   
  #   it 'combines street, city, state, and zip code values into a single address string' do
  #     event.address.should == "1445 New York Ave. NW, Suite 201, Washington, DC 20005"
  #     event.update_attribute :street2, nil
  #     event.address.should == "1445 New York Ave. NW, Washington, DC 20005"
  #   end
  # end
  # 
  # describe '#nearby_restaurants' do
  #   let!(:event)      { Event.create event_attributes  }
  #   let!(:restaurant) { FactoryGirl.create :restaurant }
  # 
  #   it 'returns a collection of nearby restaurants' do
  #     event.nearby_restaurants.include?(restaurant).should be_true
  #   end
  # end
end