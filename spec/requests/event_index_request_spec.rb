require 'spec_helper'

describe 'Event index page' do
  context "when authenticated" do
    before(:each) do
      visit root_path
      page.find("#get_started").click
      page.find("#foursquare_login").click
    end
    
    context "with existing events" do
      let!(:user_1)   { User.last }
      let!(:event_1)  { FactoryGirl.create :event, user_id: user_1.id }
      let!(:user_2)   { FactoryGirl.create :user }
      let!(:event_2)  { FactoryGirl.create :event, user_id: user_2.id }
      
      before(:each) do
        visit events_path
      end
      
      it "displays all of the events for the current user" do
        page.should have_selector "#event_#{event_1.id}"
      end
      
      it "does not display events for other users" do
        page.should_not have_selector "#event_#{event_2.id}"
      end
    end
    
    context "with no events" do
      let!(:user_2)   { FactoryGirl.create :user }
      let!(:event_2)  { FactoryGirl.create :event, user_id: user_2.id }
      
      before(:each) do
        visit events_path
      end
      
      it "displays a message saying that you have no events" do
        page.should have_selector "#no_events"
        page.find("#no_events").should have_content "You have no events."
      end
      
      it "does not display events for other users" do
        page.should_not have_selector "#event_#{event_2.id}"
      end
    end
  end
end