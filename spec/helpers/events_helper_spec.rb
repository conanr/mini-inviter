require 'spec_helper'

describe EventsHelper do
  describe "display_restaurant_names" do
    let!(:event)        { FactoryGirl.create :event }
    
    context "when an event has restaurant options" do
      let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
      let!(:restaurant_2) { FactoryGirl.create :cafe_mozart }
      let!(:restaurant_option_1)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_1.id }
      let!(:restaurant_option_2)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_2.id }
      
      it "returns a comma-separated list of restaurant names" do
        display_restaurant_names(event).should == "#{restaurant_1.name}, #{restaurant_2.name}"
      end
    end
    
    context "when an event does not have restaurant options" do
      it "returns an empty string" do
        display_restaurant_names(event).should == ""
      end
    end
  end
end