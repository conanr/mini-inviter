require 'spec_helper'

describe "site authentication" do
  describe "when authenticating via oauth providers" do
    before :each  do
      visit signin_path
    end

    describe "using foursquare" do
      context "as a new user" do
        it "creates an account with information from oauth and displays their name on the page" do
          expect { page.find("#foursquare_login").click }.to change { User.count }.by 1
          user = User.last
          user.first_name.should  == "Paula"
          user.last_name.should   == "Brewman"
          user.email.should       == "dcbrewman@example.org"

          auth = User.last.authentications.last
          auth.provider.should  == "foursquare"
          auth.uid.should       == "1234"
          auth.token.should     == "3NH22I530TIAIY5CXWPMUD44LT0D2FEDY0IBX0NY2QNE1SNL"
        
          page.find(".navbar").should have_content "Paula Brewman"
        end
      end
    
      context "as an existing user" do
        it "logs the user into the site" do
          page.find("#foursquare_login").click
          page.find(".navbar").should have_content "Paula Brewman"
        end
      end
    end
  
    describe "using facebook" do
      context "as a new user" do
        it "creates an account with information from oauth and displays their name on the page" do
          expect { page.find("#facebook_login").click }.to change { User.count }.by 1
          user = User.last
          user.first_name.should  == "Niels"
          user.last_name.should   == "Bohr"
          user.email.should       == "n.bohr@example.org"

          auth = User.last.authentications.last
          auth.provider.should  == "facebook"
          auth.uid.should       == "098765"
          auth.token.should     == "PMUD44LT0D2FEDY0IBX0NY2QNE1SNL3NH22I530TIAIY5CXW"
        
          page.find(".navbar").should have_content "Niels Bohr"
        end
      end
    
      context "as an existing user" do
        it "logs the user into the site" do
          page.find("#facebook_login").click
          page.find(".navbar").should have_content "Niels Bohr"
        end
      end
    end
    
    describe "with no existing events" do
      it "redirects the user to the event create page" do
        page.find("#facebook_login").click
        URI.parse(current_url).path.should == new_event_path
      end
    end
    
    describe "with existing events" do
      let!(:user)             { FactoryGirl.create :user, email: "n.bohr@example.org", first_name: "Niels", last_name: "Bohr"}
      let!(:authentication)   { FactoryGirl.create :facebook_auth, user_id: user.id }
      let!(:event)            { FactoryGirl.create :event, user_id: user.id }
      
      it "redirects the user to the event index page" do
        page.find("#facebook_login").click
        URI.parse(current_url).path.should == events_path
      end
    end
  end
  
  describe "loggin out" do
    before :each  do
      visit signin_path
      page.find("#facebook_login").click
      page.find("#signout").click
    end
    
    it "no longer displays the user's name nor the signout link in the navbar" do
      page.find(".navbar").should_not have_content "Niels Bohr"
      page.should_not have_selector "#signout"
    end
    
    it "displays a signin link in the navbar" do
      page.should have_selector "#signin"
    end
  end
end