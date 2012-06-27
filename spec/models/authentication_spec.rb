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
    
  end
end
