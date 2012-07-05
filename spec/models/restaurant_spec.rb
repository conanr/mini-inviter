require 'spec_helper'
require 'nokogiri'

describe Restaurant do
  it "has a name" do
    restaurant = Restaurant.create name: "Hello Restaurant"
    restaurant.name.should == "Hello Restaurant"
  end

  it "has an address" do
    restaurant = Restaurant.create name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005"
    restaurant.address.should == "1445 New York Ave. NW, Washington, DC 20005"
  end

  it "has a LivingSocial ID" do
    restaurant = Restaurant.create name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005", ls_id: "2342"
    restaurant.ls_id.should == "2342"
  end
  
  it "requires a name" do
    restaurant = Restaurant.create address: "1445 New York Ave. NW, Washington, DC 20005", ls_id: "123"
    restaurant.valid?.should be_false
  end
    
  it "requires an address" do
    restaurant = Restaurant.create name: "Hello Restaurant"
    restaurant.valid?.should be_false
  end
  
  it "requires a unique LivingSocial ID" do
    Restaurant.create name: "Hello", address: "1445 New York Ave. NW, Washington, DC 20005", ls_id: "123"
    restaurant = Restaurant.create name: "Goodbye", address: "123 11th St. NW, Washington, DC 20001", ls_id: "123"
    restaurant.valid?.should be_false
  end
  
  it "has an image url" do
    restaurant = Restaurant.create name: "Hello", 
        address: "1445 New York Ave. NW, Washington, DC 20005", 
        ls_id: "123",
        image_url: "https://a248.e.akamai.net/si.lscdn.net/imgs/8bff096f-e7a2-4c9b-93a3-e90845394aff/139_q60.jpg"
    restaurant.image_url.should == "https://a248.e.akamai.net/si.lscdn.net/imgs/8bff096f-e7a2-4c9b-93a3-e90845394aff/139_q60.jpg"
  end
  
  describe ".import_from_ls_page" do
    it "creates a new restaurant from a scraped LS page" do
      scraped_page = Nokogiri::HTML(File.open('spec/support/assets/ls_toad_show_dc_indian_delight.html'))
      restaurant = Restaurant.import_from_ls_page scraped_page
      restaurant.name.should      == "Indian Delight"
      restaurant.address.should   == "1100 Pennsylvania Avenue NW Washington, DC 20004"
      restaurant.ls_id.should     == "7356"
      restaurant.image_url.should == "https://a248.e.akamai.net/si.lscdn.net/imgs/8bff096f-e7a2-4c9b-93a3-e90845394aff/139_q60.jpg"
    end
    
    it "can pass in specific LS ID if known" do
      known_ls_id  = "1234"
      scraped_page = Nokogiri::HTML(File.open('spec/support/assets/ls_toad_show_dc_indian_delight.html'))
      restaurant = Restaurant.import_from_ls_page scraped_page, known_ls_id
      restaurant.name.should      == "Indian Delight"
      restaurant.address.should   == "1100 Pennsylvania Avenue NW Washington, DC 20004"
      restaurant.ls_id.should     == known_ls_id
      restaurant.image_url.should == "https://a248.e.akamai.net/si.lscdn.net/imgs/8bff096f-e7a2-4c9b-93a3-e90845394aff/139_q60.jpg"
    end
    
    it "does not import the same restaurant twice" do
      scraped_page = Nokogiri::HTML(File.open('spec/support/assets/ls_toad_show_dc_indian_delight.html'))
      expect { 
        Restaurant.import_from_ls_page scraped_page
        Restaurant.import_from_ls_page scraped_page
      }.to change { Restaurant.count }.by 1
    end
  end
  
  describe ".all_close_to" do
    let!(:home) { "1100 Pennsylvania Avenue NW Washington, DC 20004" }
    let!(:nearby_place)  { Restaurant.create name: "Sushi Go Round", address: "705 7th Street NW Washington, DC 20001", ls_id: "2166" }
    let!(:too_far_place) { Restaurant.create name: "Sine Irish Pub", address: "1301 S Joyce Street Arlington, VA 22202", ls_id: "7104" }
    
    it "returns all restaurants near to a given address" do
      Restaurant.stub(:near).and_return([nearby_place])
      restaurants = Restaurant.all_close_to(home)
      restaurants.include?(nearby_place).should be_true
      restaurants.include?(too_far_place).should be_false
    end
  end
end