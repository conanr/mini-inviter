require 'spec_helper'

describe "events show page" do
  let!(:user)   { FactoryGirl.create :user  }
  let!(:event)  { FactoryGirl.create :event, user_id: user.id }

  describe "when navigating to the page" do
    context "when not authenticated as the event creator" do
      before :each do
        visit signin_path
        page.find("#foursquare_login").click
      end
      
      it "returns a 404 error" do
        begin
          visit event_path event
        rescue StandardError => ex
          result = :exception_handled
        end

        result.should == :exception_handled
        ex.is_a?(ActionController::RoutingError).should be_true
      end 
    end
  end
end