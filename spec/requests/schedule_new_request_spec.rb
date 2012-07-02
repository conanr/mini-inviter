require 'spec_helper'

describe 'schedule new page' do
  let!(:user)           { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication) { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)          { user.events.create(name: "Test Event") }
  
  context "when authenticated as the event owner" do
    before(:each) do
      visit signin_path
      page.find("#facebook_login").click
      visit new_event_schedule_path event
    end
    
    context "when selecting an invalid start time" do
      before(:each) do
        start_time = 3.days.ago
        within '#event_time_form' do
          select start_time.strftime('%Y'),  from: 'schedule_start_time_1i'
          select start_time.strftime('%B'),  from: 'schedule_start_time_2i'
          select start_time.strftime('%-d'), from: 'schedule_start_time_3i'
          select start_time.strftime('%H'),  from: 'schedule_start_time_4i'
          select start_time.strftime('%M'),  from: 'schedule_start_time_5i'
        end
        page.find("#submit_event_time_form").click
      end
      
      it "redirects the user back to the event schedule new form" do
        URI.parse(current_url).path.should == event_schedules_path(event)
      end
      
      it "displays an error that the event name can not be in the past" do
        page.find("#error_details").should have_content "Start time must have a valid value"
      end
    end
    
    context "when selecting an valid start time" do
      let!(:start_time)   { 3.days.from_now.change(:sec => 0) }

      before(:each) do
        within '#event_time_form' do
          select start_time.strftime('%Y'),  from: 'schedule_start_time_1i'
          select start_time.strftime('%B'),  from: 'schedule_start_time_2i'
          select start_time.strftime('%-d'), from: 'schedule_start_time_3i'
          select start_time.strftime('%H'),  from: 'schedule_start_time_4i'
          select start_time.strftime('%M'),  from: 'schedule_start_time_5i'
        end
        page.find("#submit_event_time_form").click
      end
      
      it "redirects the user back to the event schedule new form" do
        URI.parse(current_url).path.should == new_event_address_path(event)
      end
      
      it "displays an error that the event name can not be in the past" do
        event.schedule.start_time.should == start_time
      end
    end
  end
  
  context "when authenticated as some user other than the event owner" do
    before(:each) do
      visit signin_path
      page.find("#foursquare_login").click
    end
    
    it "returns a 404 error page" do
      begin
        visit new_event_schedule_path event
      rescue StandardError => ex
        result = :exception_handled
      end

      result.should == :exception_handled
      ex.is_a?(ActionController::RoutingError).should be_true
    end
  end
end