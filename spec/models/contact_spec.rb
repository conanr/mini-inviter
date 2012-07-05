require 'spec_helper'

describe Contact do
  let!(:contact_attributes)  { { name: "Todd Fowler", email: "todd.fowler@example.com" } }
  
  context "with invalid data" do
    it "rejects blank names" do
      ["    ", nil].each do |invalid_name|
        contact_attributes[:name] = invalid_name
        contact = Contact.create contact_attributes
        contact.valid?.should be_false
      end
    end
  
    it "rejects invalid email addresses" do
      ["   ", nil, "jean@", "@depaul.com"].each do |invalid_email|
        contact_attributes[:email] = invalid_email
        contact = Contact.create contact_attributes
        contact.valid?.should be_false
      end
    end
  end
  
  context "with valid data" do
    let!(:contact)  { Contact.create contact_attributes }
    
    it "accepts a non-blank name" do
      contact.valid?.should be_true
      contact.name.should == contact_attributes[:name]
    end
    
    it "accepts a valid email address" do
      contact.valid?.should be_true
      contact.email.should == contact_attributes[:email]
    end
  end
  
  it "can not be a duplicate of an existing contact for the user"
end
