require 'spec_helper'

describe "Creating an new invitation" do
  context "as a brand new user" do    
    context "from the home page" do
      before(:each) do
        visit root_path
      end
      
      it "displays the invitation details after creating one" do
        page.find("#get_started").click
        page.find("#foursquare_login").click
        
        # fill in date form
        # fill in address form
        # select a restaurant from list
        # invite a friend
        # create the invitation
        
        # view the results
        
      end
    end
  end
end