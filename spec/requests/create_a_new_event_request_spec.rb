require 'spec_helper'

describe "Creating an new event" do
  context "as a brand new user" do
    context "from the home page" do
      let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
      let!(:restaurant_2) { FactoryGirl.create :cafe_mozart }
      let!(:restaurant_3) { FactoryGirl.create :mayur_kabob_house }
      
      before(:each) do
        Restaurant.stub(:near).and_return([restaurant_1, restaurant_2, restaurant_3])
        visit root_path
      end
      
      it "displays the event details after creating one" do
        # login
        page.find("#get_started").click
        page.find("#foursquare_login").click
        page.find(".navbar").should have_content "Paula Brewman"
        
        # create the stub event
        party_name = "My Birthday Party"
        within '#event_form' do
          fill_in 'event_name', with: party_name
        end
        page.find("#submit_event_form").click
        page.should have_content party_name
        
        # set a start time for the event
        start_time = 3.days.from_now
        within '#event_time_form' do
          select start_time.strftime('%Y'),  from: 'schedule_start_time_1i'
          select start_time.strftime('%B'),  from: 'schedule_start_time_2i'
          select start_time.strftime('%-d'), from: 'schedule_start_time_3i'
          select start_time.strftime('%H'),  from: 'schedule_start_time_4i'
          select start_time.strftime('%M'),  from: 'schedule_start_time_5i'
        end
        page.find("#submit_event_time_form").click
        page.should have_content start_time.strftime('%F %R')
        
        # set a place for the event
        party_place = { street1: "1445 New York Ave. NW", street2: "Suite #200", city: "Washington", state: "DC", zip_code: "20005" }
        within '#event_address_form' do
          fill_in "address_street1", with: party_place[:street1]
          fill_in "address_street2", with: party_place[:street2]
          fill_in "address_city", with: party_place[:city]
          fill_in "address_zip_code", with: party_place[:zip_code]
          select party_place[:state], from: "address_state"
        end
        page.find("#submit_event_address_form").click
        party_place.each do |p|
          page.should have_content p.last
        end
        
        # select restaurants for the event
        within '#restaurant_selection' do
          check restaurant_2.name
          check restaurant_3.name
        end
        page.find("#submit_selection_form").click
        page.should have_content restaurant_2.name
        page.should have_content restaurant_3.name
        
        # invite friends to the event
        invitees = [ { name: "John Doe",    email: "joedoe@example.com" },
                     { name: "Paula Jones", email: "p.jones@example.com" },
                     { name: "Tom Paine",   email: "t.paine@example" } ]
        within '#event_invite_form' do
          invitees.each_with_index do |invitee, i|
            fill_in "new_contacts[#{i+1}][name]",  with: invitee[:name]
            fill_in "new_contacts[#{i+1}][email]", with: invitee[:email]
          end
        end
        page.find("#submit_event_invite_form").click
        
        # verify the event details are displayed
        page.should have_content party_name
        page.should have_content start_time.strftime('%F %R')
        party_place.each do |p|
          page.should have_content p.last
        end
        invitees.each do |invitee|
          page.should have_content invitee[:name]
          page.should have_content invitee[:email]
        end
      end
    end
  end
end