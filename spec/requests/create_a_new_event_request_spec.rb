require 'spec_helper'

describe "Creating an new event" do
  context "as a brand new user" do
    context "from the home page" do
      let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
      let!(:restaurant_2) { FactoryGirl.create :cafe_mozart }
      let!(:restaurant_3) { FactoryGirl.create :mayur_kabob_house }
      
      before(:each) do
        visit root_path
      end
      
      it "displays the event details after creating one" do
        # login
        page.find("#get_started").click
        page.find("#foursquare_login").click
        
        # create the event
        page.find("#get_started").click
        within '#event_form' do
          fill_in 'event_name', with: "My Birthday Party"
        end
        page.find("#submit_event_form").click
        page.should have_content "My Birthday Party"
        
        # fill in date form
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
        
        # fill in address form
        party_place = { street1: "1445 New York Ave. NW", street2: "Suite #200", city: "Washington", state: "DC", zip_code: "20005" }
        within '#event_address_form' do
          party_place.each do |p|
            fill_in "address_#{p.first}", with: p.last
          end
        end
        page.find("#submit_event_address_form").click
        party_place.each do |p|
          page.should have_content p.last
        end
        
        # select a restaurant from list
        within '#restaurant_selection' do
          check restaurant_2.name
        end
        page.find("#submit_selection_form").click
        page.should have_content restaurant_2.name
        
        # invite a friend
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
        invitees.each do |invitee|
          page.should have_content invitee[:name]
          page.should have_content invitee[:email]
        end

        # send the invitations
        
        # view the results
        
      end
    end
  end
end