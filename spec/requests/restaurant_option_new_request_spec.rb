require 'spec_helper'

describe 'Restaurant Options New Page' do
  let!(:user)           { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication) { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)          { FactoryGirl.create :event, user_id: user.id }
  let!(:restaurant_1)   { FactoryGirl.create :sushi_go_round }
  let!(:restaurant_2)   { FactoryGirl.create :cafe_mozart }
  let!(:restaurant_3)   { FactoryGirl.create :mayur_kabob_house }

  before(:each) do
    Restaurant.stub(:near).and_return([restaurant_1, restaurant_2, restaurant_3])
  end
  
  context "when authenticated as the event owner" do
    before(:each) do
      visit signin_path
      page.find("#facebook_login").click
      visit new_event_restaurant_option_path event
    end
  
    context "when selecting no restaurants" do
      before(:each) do
        page.find("#submit_selection_form").click
      end
      
      it "redirects the user back to the event restaurant option new form" do
        URI.parse(current_url).path.should == new_event_restaurant_option_path(event)
      end
      
      it "displays an error stating that at least one option must be selected" do
        page.find("#alert").should have_content "Please select two or more restaurants."
      end
    end
    
    context "when selecting a restaurant" do
      before(:each) do
        within '#restaurant_selection' do
          check restaurant_2.name
          check restaurant_3.name
        end
        page.find("#submit_selection_form").click
      end
      
      it "redirects the user to the event invites new form" do
        URI.parse(current_url).path.should == new_event_invite_path(event)
      end

      it "saves the correct restaurant option information for the event" do
        event.restaurant_options.count.should == 2
        event.restaurant_options.collect { |ro| ro.name }.sort.should == ["Cafe Mozart", "Mayur Kabob House"]
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
        visit new_event_restaurant_option_path event
      rescue StandardError => ex
        result = :exception_handled
      end

      result.should == :exception_handled
      ex.is_a?(ActionController::RoutingError).should be_true
    end
  end
end