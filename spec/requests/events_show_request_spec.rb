require 'spec_helper'

describe "events show page" do
  let!(:user)             { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
  let!(:authentication)   { FactoryGirl.create :facebook_auth, user_id: user.id }
  let!(:event)            { FactoryGirl.create :event, user_id: user.id }
  let!(:restaurant_1)     { FactoryGirl.create :sushi_go_round }
  let!(:restaurant_2)     { FactoryGirl.create :cafe_mozart }
  let!(:restaurant_option_1)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_1.id }
  let!(:restaurant_option_2)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_2.id }
  let!(:contact)  { FactoryGirl.create :contact, user_id: user.id }
  let!(:invite)   { FactoryGirl.create :invite, contact_id: contact.id, event_id: event.id }
  
  describe "when navigating to the page" do
    context "when not authenticated as the event creator" do
      before(:each) do
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
    
    context "when authed authenticated as the event creator" do
      before(:each) do
        visit signin_path
        page.find("#facebook_login").click
        visit event_path event
      end
      
      it "takes the user to the event show page" do
        URI.parse(current_url).path.should == event_path(event)
      end
      
      it "displays the event's details" do
        page.find("#event_name").should have_content event.name
        page.find("#event_start_time").should have_content event.start_time
        page.find("#event_address").should have_content event.full_address
      end
      
      it "displays all of the event's invitees" do
        event.invites.each do |i|
          page.find("#event_invites").should have_content i.name
          page.find("#event_invites").should have_content i.email
        end
      end
      
      it "displays all of the event's restaurants" do
        event.restaurant_options.each do |ro|
          page.find("#event_restaurants").should have_content ro.name
        end
      end
      
      context "if an invitee has voted for a restaurant" do
        let!(:restaurant_vote)  { RestaurantVote.create invite_id: invite.id, restaurant_option_id: restaurant_option_2.id }
        
        before(:each) do
          visit event_path event
        end
        
        it "displays the correct vote tally for each restaurant" do
          page.find("#votes_for_#{restaurant_option_1.id}").text.should == "(0 votes)"
          page.find("#votes_for_#{restaurant_option_2.id}").text.should == "(1 vote)"
        end
        
        it "displays which restaurant an invitee voted for" do
          page.find("#invitee_choice_#{invite.id}").should have_content restaurant_option_2.name
        end
      end
    end
  end
end