require 'spec_helper'
require 'nokogiri'

describe Restaurant do
  let!(:restaurant_attributes)  { {
                                    name: "Hello Restaurant",
                                    address: "1445 New York Ave. NW, Washington, DC 20005",
                                    ls_id: "2342",
                                    image_url: "https://a248.e.akamai.net/si.lscdn.net/imgs/8bff096f-e7a2-4c9b-93a3-e90845394aff/139_q60.jpg"
                                } }

  context "using invalid data" do
    it "rejects blank names" do
      ["    ", nil].each do |invalid_name|
        restaurant_attributes[:name] = invalid_name
        restaurant = Restaurant.create restaurant_attributes
        restaurant.valid?.should be_false
      end
    end
    
    it "rejects blank addresses" do
      ["    ", nil].each do |invalid_address|
        restaurant_attributes[:name] = invalid_address
        restaurant = Restaurant.create restaurant_attributes
        restaurant.valid?.should be_false
      end
    end
    
    it "rejects duplicate LivingSocial ID" do
      Restaurant.create restaurant_attributes
      restaurant = Restaurant.create restaurant_attributes
      restaurant.valid?.should be_false
    end
  end
  
  context "using valid data" do
    let!(:restaurant)   { Restaurant.create restaurant_attributes }

    it "accepts a non-blank name" do
      restaurant.valid?.should be_true
      restaurant.name.should == restaurant_attributes[:name]
    end

    it "accepts a non-blank address" do
      restaurant.valid?.should be_true
      restaurant.address.should == restaurant_attributes[:address]
    end

    it "accepts a unique LivingSocial ID" do
      restaurant.valid?.should be_true
      restaurant.ls_id.should == restaurant_attributes[:ls_id]
    end

    it "may have an image url" do
      restaurant.valid?.should be_true
      restaurant.image_url.should == restaurant_attributes[:image_url]
    end
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