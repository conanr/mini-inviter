require 'spec_helper'

describe RestaurantVote do
  let!(:user)         { FactoryGirl.create :user  }
  let!(:event)        { FactoryGirl.create :event }
  let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
  let!(:option)       { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_1.id }
  let!(:contact)      { FactoryGirl.create :contact, user_id: user.id }
  let!(:invite)       { FactoryGirl.create :invite, contact_id: contact.id, event_id: event.id }
  
  it "only allows only vote per invite" do
    expect {
      RestaurantVote.create(invite_id: invite.id, restaurant_option_id: option.id)
      RestaurantVote.create(invite_id: invite.id, restaurant_option_id: option.id)
    }.to change { RestaurantVote.count }.by 1
  end
end