require 'spec_helper'

describe Address do
  let!(:event_address) { { street1:    "1445 New York Ave. NW",
                           street2:    "Suite 201",
                           city:       "Washington",
                           state:      "DC",
                           zip_code:   "20005" } }
  
  
  it 'requires a non-blank primary street address' do
    event_address[:street1] = nil
    address = Address.create event_address
    address.valid?.should be_false
    
    address.update_attribute :street1, "    "
    address.valid?.should be_false
  
    address.update_attribute :street1, "1445 New York Ave. NW"
    address.valid?.should be_true
    address.street1.should == "1445 New York Ave. NW"
  end
  
  it 'may have a secondary street address' do
    address = Address.create event_address
    address.street2.should == "Suite 201"
  end
  
  it 'requires a non-blank city' do
    event_address[:city] = nil
    address = Address.create event_address
    address.valid?.should be_false
    
    address.update_attribute :city, "    "
    address.valid?.should be_false
  
    address.update_attribute :city, "Washington"
    address.valid?.should be_true
    address.city.should == "Washington"
  end
  
  it 'requires a valid state abbreviation' do
    event_address[:state] = nil
    address = Address.create event_address
    address.valid?.should be_false
    
    address.update_attribute :state, "    "
    address.valid?.should be_false
  
    address.update_attribute :state, "ZZ"
    address.valid?.should be_false
    
    address.update_attribute :state, "DC"
    address.valid?.should be_true
    address.state.should == "DC"
  end
  
  it 'requires a valid zip code' do
    event_address[:zip_code] = nil
    address = Address.create event_address
    address.valid?.should be_false
    
    address.update_attribute :zip_code, "    "
    address.valid?.should be_false
  
    address.update_attribute :zip_code, "ABCDE"
    address.valid?.should be_false
  
    address.update_attribute :zip_code, "2000"
    address.valid?.should be_false
    
    address.update_attribute :zip_code, "20005"
    address.valid?.should be_true
    
    address.update_attribute :zip_code, "20005-123"
    address.valid?.should be_false
    
    address.update_attribute :zip_code, "20005-1234"
    address.valid?.should be_true
    address.zip_code.should == "20005-1234"
  end
  
  describe '#full_address' do
    let!(:address)      { Address.create event_address }
    
    it 'combines street, city, state, and zip code values into a single address string' do
      address.full_address.should == "1445 New York Ave. NW, Suite 201, Washington, DC 20005"
      address.update_attribute :street2, nil
      address.full_address.should == "1445 New York Ave. NW, Washington, DC 20005"
    end
  end
end
