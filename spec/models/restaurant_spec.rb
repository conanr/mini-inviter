require 'spec_helper'

describe Restaurant do
  it "has a name" do
    restaurant = Restaurant.create(name: "Hello Restaurant")
    restaurant.name.should == "Hello Restaurant"
  end

  it "has an address" do
    restaurant = Restaurant.create(name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005")
    restaurant.address.should == "1445 New York Ave. NW, Washington, DC 20005"
  end

  it "requires a name" do
    restaurant = Restaurant.create()
    restaurant.valid?.should be_false
  end
    
  it "requires an address" do
    restaurant = Restaurant.create(name: "Hello Restaurant")
    restaurant.valid?.should be_false
  end
end