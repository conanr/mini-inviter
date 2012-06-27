require 'spec_helper'

describe Authentication do
  let!(:auth_attributes) { {  provider: "foursquare", 
                              uid:      "1445",
                              token:    "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"  } }
  
  it "requires a non-blank provider" do
    auth_attributes[:provider] = nil
    auth = Authentication.create auth_attributes
    auth.valid?.should be_false

    auth.update_attribute :provider, " "
    auth.valid?.should be_false
    
    auth.update_attribute :provider, "foursquare"
    auth.valid?.should be_true
    auth.provider.should == "foursquare"
  end
  
  it "requires a non-blank uid" do
    auth_attributes[:uid] = nil
    auth = Authentication.create auth_attributes
    auth.valid?.should be_false

    auth.update_attribute :uid, " "
    auth.valid?.should be_false
    
    auth.update_attribute :uid, "1234"
    auth.valid?.should be_true
    auth.uid.should == "1234"
  end
  
  it "does not create duplicate authentications for an existing provider/uid pair" do
    expect {
      Authentication.create auth_attributes
      Authentication.create auth_attributes
    }.to change { Authentication.count }.by 1
  end
  
  it "may have a token" do
    auth = Authentication.create auth_attributes
    auth.token.should == "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"
  end
  
  describe '.from_oauth_hash' do
    let!(:user)       { FactoryGirl.create :user }
    let!(:oauth_hash) { Hashie::Mash.new(JSON.parse(File.read("spec/support/assets/foursquare_oauth_hash_test_account.txt"))) }
    
    it 'creates a new authentication if none already exist for the user' do
      auth = Authentication.from_oauth_hash(user, oauth_hash)
      auth.provider.should  == "foursquare"
      auth.uid.should       == "1234"
      auth.token.should     == "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"
      user.authentications.last.should == auth
    end
    
    it 'returns an authentication if one already exist for the user' do
      Authentication.from_oauth_hash(user, oauth_hash)
      auth = Authentication.from_oauth_hash(user, oauth_hash)
      auth.provider.should  == "foursquare"
      auth.uid.should       == "1234"
      auth.token.should     == "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"
      user.authentications.last.should == auth
    end
  end
end
