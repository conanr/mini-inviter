require 'spec_helper'
require 'nokogiri'

describe Restaurant do
  it "has a name" do
    restaurant = Restaurant.create(name: "Hello Restaurant")
    restaurant.name.should == "Hello Restaurant"
  end

  it "has an address" do
    restaurant = Restaurant.create(name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005")
    restaurant.address.should == "1445 New York Ave. NW, Washington, DC 20005"
  end

  it "has a LivingSocial ID" do
    restaurant = Restaurant.create(name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005", ls_id: "2342")
    restaurant.ls_id.should == "2342"
  end

  it "requires a name" do
    restaurant = Restaurant.create()
    restaurant.valid?.should be_false
  end
    
  it "requires an address" do
    restaurant = Restaurant.create(name: "Hello Restaurant")
    restaurant.valid?.should be_false
  end
  
  it "requires a unique LivingSocial ID" do
    Restaurant.create(name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005", ls_id: "123")
    restaurant = Restaurant.create(name: "Goodbye", address: "123 11th St. NW, Washington, DC 20001", ls_id: "123")
    restaurant.valid?.should be_false
  end
  
  describe ".import_from_ls_page" do
    it "creates a new restaurant from a scraped LS page" do
      scraped_page = Nokogiri::HTML(File.open('spec/support/assets/ls_toad_show_dc_indian_delight.html'))
      restaurant = Restaurant.import_from_ls_page(scraped_page)
      restaurant.name.should    == "Indian Delight"
      restaurant.address.should == "1100 Pennsylvania Avenue NW Washington, DC 20004"
      restaurant.ls_id.should   == "7356"
    end
    
    it "does not import the same restaurant twice" do
      scraped_page = Nokogiri::HTML(File.open('spec/support/assets/ls_toad_show_dc_indian_delight.html'))
      expect { 
        Restaurant.import_from_ls_page(scraped_page)
        Restaurant.import_from_ls_page(scraped_page)
      }.to change { Restaurant.count }.by(1)
    end
  end
end