require 'spec_helper'

describe User do
  let!(:user_attributes)  { { first_name: "Paula", last_name: "Brewman", email: "paula@example.com"} }

  context "using invalid data" do
    it "rejects blank emails" do
      ["    ", nil].each do |invalid_email|
        user_attributes[:email] = invalid_email
        user = User.create user_attributes
        user.valid?.should be_false
      end
    end
    
    it "rejects duplicate emails" do
      User.create user_attributes
      user = User.create user_attributes
      user.valid?.should be_false      
    end
  end

  context "using valid data" do
    let!(:user)   { User.create user_attributes }
    
    it "accepts non-blank emails" do
      user.valid?.should be_true
      user.email.should == user_attributes[:email]
    end
    
    it "may have a first name" do
      user.first_name.should == user_attributes[:first_name]
    end
    
    it "may have a last name" do
      user.last_name.should == user_attributes[:last_name]
    end
  end

  describe ".from_oauth_hash" do
    it "creates a new user using oauth hash" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      user = User.from_oauth_hash oauth_hash
      user.valid?.should be_true
      user.first_name.should    == oauth_hash["info"]["first_name"]
      user.last_name.should     == oauth_hash["info"]["last_name"]
      user.email.should         == oauth_hash["info"]["email"]
    end
    
    it "does not create two user records for users from the same provider" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      expect {
        User.from_oauth_hash oauth_hash
        User.from_oauth_hash oauth_hash
      }.to change { User.count }.by 1
    end
  end
  
  describe "#name" do
    it "returns a string containing the first and last name of the user" do
      oauth_hash = Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt")))
      user = User.from_oauth_hash oauth_hash
      user.name.should == oauth_hash["info"]["first_name"] + " " + oauth_hash["info"]["last_name"]
    end
  end
end
