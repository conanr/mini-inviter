require 'spec_helper'

describe 'Restaurant Options New Page' do
  let!(:user)           { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication) { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)          { FactoryGirl.create :event, user_id: user.id }
  
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