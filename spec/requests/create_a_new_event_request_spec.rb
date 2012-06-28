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
        start_time = 3.days.from_now
        within '#event_time_form' do
          select start_time.strftime('%Y'), from: 'schedule_start_time_1i'
          select start_time.strftime('%B'), from: 'schedule_start_time_2i'
          select start_time.strftime('%-d'), from: 'schedule_start_time_3i'
          select start_time.strftime('%H'), from: 'schedule_start_time_4i'
          select start_time.strftime('%M'), from: 'schedule_start_time_5i'
        end
        page.find("#submit_event_time_form").click
        page.should have_content start_time.strftime('%F %R')
        
        # fill in address form
        # select a restaurant from list
        # invite a friend
        # create the invitati on
        
        # view the results
        
      end
    end
  end
end