require 'spec_helper'

describe User do
  describe ".create_from_oauth" do
    it "creates a new user using oauth hash after Foursquare auth" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.open("spec/support/assets/foursquare_oauth_hash_test_account.txt").read))
      user = User.create_from_oauth_hash oauth_hash
      user.valid?.should be_true
      user.first_name.should    == "Paula"
      user.last_name.should     == "Brewman"
      user.email.should         == "dcbrewman@example.com"
      user.foursquare_id.should == "1234"
    end
  end
end
