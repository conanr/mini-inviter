require 'spec_helper'

describe Authentication do
  let!(:auth_attributes) { {  provider: "foursquare", 
                              uid:      "1445",
                              token:    "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"  } }
  
  context "with invalid data" do
    it "rejects blank providers" do
      [" ", nil].each do |invalid_provider|
        auth_attributes[:provider] = invalid_provider
        auth = Authentication.create auth_attributes
        auth.valid?.should be_false
      end
    end
    
    it "rejects blank uids" do
      [" ", nil].each do |invalid_uid|
        auth_attributes[:uid] = invalid_uid
        auth = Authentication.create auth_attributes
        auth.valid?.should be_false
      end
    end
  end

  context "with valid data" do
    it "accepts a non-blank provider" do
      auth = Authentication.create auth_attributes
      auth.valid?.should be_true
      auth.provider.should == auth_attributes[:provider]
    end
    
    it "accepts a non-blank uid" do
      auth = Authentication.create auth_attributes
      auth.valid?.should be_true
      auth.uid.should == auth_attributes[:uid]
    end
    
    it "does not create duplicate authentications for an existing provider/uid pair" do
      expect {
        Authentication.create auth_attributes
        Authentication.create auth_attributes
      }.to change { Authentication.count }.by 1
    end
    
    it "may have a token" do
      auth = Authentication.create auth_attributes
      auth.token.should == auth_attributes[:token]
    end
  end
  
  describe '.from_oauth_hash' do
    let!(:user)       { FactoryGirl.create :user }
    let!(:oauth_hash) { Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt"))) }
    
    it 'creates a new authentication if none already exist for the user' do
      auth = Authentication.from_oauth_hash(user, oauth_hash)
      auth.provider.should  == oauth_hash["provider"]
      auth.uid.should       == oauth_hash["uid"]
      auth.token.should     == oauth_hash["credentials"]["token"]
      user.authentications.last.should == auth
    end
    
    it 'returns an authentication if one already exist for the user' do
      Authentication.from_oauth_hash(user, oauth_hash)
      auth = Authentication.from_oauth_hash(user, oauth_hash)
      auth.provider.should  == oauth_hash["provider"]
      auth.uid.should       == oauth_hash["uid"]
      auth.token.should     == oauth_hash["credentials"]["token"]
    end
  end
end
