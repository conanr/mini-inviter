require 'spec_helper'

describe "Creating an new event" do
  context "as a brand new user" do
    context "from the home page" do
      before(:each) do
        visit root_path
      end
      
      it "displays the event details after creating one" do
        # login
        page.find("#get_started").click
        page.find("#foursquare_login").click
        
        # create the event
        page.find("#get_started").click
        within '#event_form' do
          fill_in 'event_name', with: "My Birthday Party"
        end
        page.find("#submit_event_form").click
        page.should have_content "My Birthday Party"
        
        # fill in date form
        # fill in address form
        # select a restaurant from list
        # invite a friend
        # create the invitation
        
        # view the results
        
      end
    end
  end
end