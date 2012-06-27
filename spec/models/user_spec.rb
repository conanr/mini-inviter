require 'spec_helper'

describe User do
  it "requires a unique foursquare id" do
    user = User.create first_name: "Paula", email: "paula@example.com"
    user.valid?.should be_false
    user.update_attribute :foursquare_id, "1234"
    user.valid?.should be_true
    user2 = User.create first_name: "Chris", email: "chris@example.com", foursquare_id: "1234"
    user2.valid?.should be_false
  end
  
  it "requires a unique email" do
    user = User.create first_name: "Paula", foursquare_id: "1234"
    user.valid?.should be_false
    user.update_attribute :email, "paula@example.com"
    user.valid?.should be_true
    user2 = User.create first_name: "Paula", email: "paula@example.com", foursquare_id: "5678"
    user2.valid?.should be_false
  end
  
  describe ".create_from_oauth" do
    it "creates a new user using oauth hash after Foursquare auth" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      user = User.create_from_oauth_hash oauth_hash
      user.valid?.should be_true
      user.first_name.should    == "Paula"
      user.last_name.should     == "Brewman"
      user.email.should         == "dcbrewman@example.com"
      user.foursquare_id.should == "1234"
    end
    
    it "does not create two user records for the same foursquare user" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      expect {
        User.create_from_oauth_hash oauth_hash
        User.create_from_oauth_hash oauth_hash
      }.to change { User.count }.by 1
    end
  end
  
  describe "#name" do
    it "returns a string containing the first and last name of the user" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      user = User.create_from_oauth_hash oauth_hash
      user.name.should == "Paula Brewman"
    end
  end
end
