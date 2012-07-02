require 'spec_helper'

describe "event new page" do
  context "when not authenticated" do
    it "redirects the user to the signin page" do
      visit new_event_path
      URI.parse(current_url).path.should == signin_path
    end
  end
  
  context "when authenticated" do
    before(:each) do
      visit signin_path
      page.find("#foursquare_login").click
    end
    
    context "after entering a blank value for the event name" do
      before(:each) do
        page.find("#submit_event_form").click
      end
      
      it "redirects the user back to the event new form" do
        URI.parse(current_url).path.should == events_path
      end
      
      it "displays an error that the event name can not be blank" do
        page.find("#error_details").should have_content "Name can't be blank"
      end
    end
    
    context "after entering a valid value for the event name" do
      before(:each) do
        within '#event_form' do
          fill_in 'event_name', with: "Aloha aloha!"
        end
        page.find("#submit_event_form").click
      end
      
      it "successfully saves the event" do
        Event.last.name.should == "Aloha aloha!"
      end

      it "redirects the user back to the schedule new form" do
        URI.parse(current_url).path.should == new_event_schedule_path(Event.last)
      end
    end
  end
end