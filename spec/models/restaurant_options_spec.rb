require 'spec_helper'

describe RestaurantOption do
  describe "#vote_count" do
    let!(:restaurant) { FactoryGirl.create :sushi_go_round }
    let!(:restaurant_option)  { FactoryGirl.create :restaurant_option, restaurant_id: restaurant.id }
    
    context "if no one has voted yet" do    
      it "returns zero" do
        restaurant_option.vote_count.should == 0
      end
    end
    
    context "if someone has voted" do
      let!(:restaurant_vote)  { FactoryGirl.create :restaurant_vote, restaurant_option_id: restaurant_option.id }
    
      it "returns the number of votes" do
        restaurant_option.vote_count.should == 1
      end
    end
  end
end