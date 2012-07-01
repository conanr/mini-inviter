require 'spec_helper'

describe Contact do
  let!(:contact_attributes)  { { name: "Todd Fowler", email: "todd.fowler@example.com" } }
  
  it "requires a non-blank name" do
    contact_attributes[:name] = nil
    contact = Contact.create contact_attributes
    contact.valid?.should be_false
    
    contact_attributes[:name] = "    "
    contact.update_attributes contact_attributes
    contact.valid?.should be_false
    
    contact_attributes[:name] = "Jean dePaul"
    contact.update_attributes contact_attributes
    contact.valid?.should be_true
  end
  
  it "requires a valid email address" do
    contact_attributes[:email] = nil
    contact = Contact.create contact_attributes
    contact.valid?.should be_false
    
    contact_attributes[:email] = "    "
    contact.update_attributes contact_attributes
    contact.valid?.should be_false

    contact_attributes[:email] = "jean@"
    contact.update_attributes contact_attributes
    contact.valid?.should be_false
    
    contact_attributes[:email] = "@depaul.com"
    contact.update_attributes contact_attributes
    contact.valid?.should be_false

    contact_attributes[:email] = "jean@example.com"
    contact.update_attributes contact_attributes
    contact.valid?.should be_true
  end
  
  it "can not be a duplicate of an existing contact for the user"
end
