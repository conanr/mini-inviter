require 'spec_helper'

describe Address do
  let!(:event_address) { { street1:    "1445 New York Ave. NW",
                           street2:    "Suite 201",
                           city:       "Washington",
                           state:      "DC",
                           zip_code:   "20005" } }
  
  context "with invalid data" do
    it 'rejects blank primary street addresses' do
      ["    ", nil].each do |invalid_street1|
        event_address[:street1] = invalid_street1
        address = Address.create event_address
        address.valid?.should be_false
      end
    end
    
    it 'rejects blank city values' do
      ["    ", nil].each do |invalid_city|
        event_address[:city] = invalid_city
        address = Address.create event_address
        address.valid?.should be_false
      end
    end
    
    it 'rejects invalid state abbreviations' do
      ["    ", nil, "ZZ"].each do |invalid_city|
        event_address[:state] = nil
        address = Address.create event_address
        address.valid?.should be_false
      end
    end
    
    it 'rejects invalid zip codes' do
      ["  ", nil, "2000", "ABCDE", "20005-123"].each do |invalid_zip|
        event_address[:zip_code] = invalid_zip
        address = Address.create event_address
        address.valid?.should be_false
      end
    end
  end
  
  context "with valid data" do
    let!(:address)   { Address.create event_address }
    
    it 'accepts a non-blank primary street address' do
      address.valid?.should be_true
      address.street1.should == event_address[:street1]
    end
    
    it 'may have a secondary street address' do
      address.street2.should == "Suite 201"
    end
  
    it 'accepts a non-blank city' do
      address.valid?.should be_true
      address.city.should == "Washington"
    end
  
    it 'accepts a valid state abbreviation' do
      address.valid?.should be_true
      address.state.should == "DC"
    end
    
    it 'accepts a valid zip code' do
      ["20005", "20005-1234"].each do |valid_zip|
        event_address[:zip_code] = valid_zip
        address = Address.create event_address
        address.valid?.should be_true
        address.zip_code.should == valid_zip
      end
    end
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
