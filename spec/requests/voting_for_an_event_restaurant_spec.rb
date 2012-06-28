require 'spec_helper'

describe 'voting for an event restaurant' do
  describe 'as an invitee' do
    let!(:user)   { FactoryGirl.create :user  }
    let!(:event)  { FactoryGirl.create :event, user_id: user.id }
    let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
    let!(:restaurant_2) { FactoryGirl.create :cafe_mozart }
    let!(:restaurant_option_1)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_1.id }
    let!(:restaurant_option_2)  { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_2.id }
    let!(:contact)  { FactoryGirl.create :contact, user_id: user.id }
    let!(:invite)   { FactoryGirl.create :invite, contact_id: contact.id, event_id: event.id }
    
    context "by visiting the vote url" do
      before :each do
        visit vote_for_restaurant_path invite_id: invite.id, option_id: restaurant_option_2.id
      end
      it "registers a vote for the selected restaurant" do
        event.restaurant_options.find(restaurant_option_2.id).vote_count.should == 1
        event.restaurant_options.find(restaurant_option_1.id).vote_count.should == 0
      end
    end
  end
end