require 'spec_helper'

describe 'Invites New Page' do
  let!(:user)           { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication) { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)          { FactoryGirl.create :event, user_id: user.id }
  
  context "when authenticated as the event owner" do
    before(:each) do
      visit signin_path
      page.find("#facebook_login").click
      visit new_event_invite_path event
    end
    
    it "displays the event invite new form" do
      page.should have_selector "#event_invite_form"
    end
  end
  
  context "when authenticated as some user other than the event owner" do
    before(:each) do
      visit signin_path
      page.find("#foursquare_login").click
    end
    
    it "returns a 404 error page" do
      begin
        visit new_event_invite_path event
      rescue StandardError => ex
        result = :exception_handled
      end

      result.should == :exception_handled
      ex.is_a?(ActionController::RoutingError).should be_true
    end
  end
end