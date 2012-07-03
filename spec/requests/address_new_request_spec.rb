require 'spec_helper'

describe 'address new page' do
  let!(:user)           { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication) { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)          { user.events.create(name: "Test Event") }
  let!(:start_time)     { event.create_schedule(start_time: 3.days.from_now) }
  
  context "when authenticated as the event owner" do
    before(:each) do
      visit signin_path
      page.find("#facebook_login").click
      visit new_event_address_path event
    end
    
    context "when entering invalid address information" do
      before(:each) do
        page.find("#submit_event_address_form").click
      end
      
      it "redirects the user back to the event schedule new form" do
        URI.parse(current_url).path.should == event_addresses_path(event)
      end
      
      it "displays errors for each field missing a value" do
        page.find("#error_details").should have_content "Street1 can't be blank"
        page.find("#error_details").should have_content "City can't be blank"
        page.find("#error_details").should have_content "State must be a valid US state"
        page.find("#error_details").should have_content "Zip code must be a valid US zip code"
      end
    end
    
    context "when entering valid address information" do
      let!(:party_place) { {
                              street1: "1445 New York Ave. NW", 
                              street2: "Suite #200", 
                              city: "Washington", 
                              state: "DC", 
                              zip_code: "20005" } }
      before(:each) do
        within '#event_address_form' do
          party_place.each do |p|
            fill_in "address_#{p.first}", with: p.last
          end
        end
        page.find("#submit_event_address_form").click
      end

      it "redirects the user to the event restaurant options new form" do
        URI.parse(current_url).path.should == new_event_restaurant_option_path(event)
      end

      it "saves the correct event address information" do
        event.address.street1.should  == party_place[:street1]
        event.address.street2.should  == party_place[:street2]
        event.address.city.should     == party_place[:city]
        event.address.state.should    == party_place[:state]
        event.address.zip_code.should == party_place[:zip_code]
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
        visit new_event_address_path event
      rescue StandardError => ex
        result = :exception_handled
      end

      result.should == :exception_handled
      ex.is_a?(ActionController::RoutingError).should be_true
    end
  end
end