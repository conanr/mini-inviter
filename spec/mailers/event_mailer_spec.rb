require 'spec_helper'

describe EventMailer do
  describe 'invite' do
    let!(:user)         { FactoryGirl.create :user}
    let!(:event)        { FactoryGirl.create :event, user_id: user.id }
    let!(:restaurant_1) { FactoryGirl.create :sushi_go_round }
    let!(:restaurant_2) { FactoryGirl.create :cafe_mozart }
    let!(:restaurant_option_1) { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_1.id }
    let!(:restaurant_option_2) { FactoryGirl.create :restaurant_option, event_id: event.id, restaurant_id: restaurant_2.id }
    let!(:contact)  { FactoryGirl.create :contact, user_id: user.id }
    let!(:invite)   { Invite.create event_id: event.id, contact_id: contact.id }
    
    it "should render without error" do
      lambda { EventMailer.create_invite invite }.should_not raise_error
    end
    
    describe "rendered without error" do
      let!(:mailer)       { EventMailer.create_invite invite }
      let!(:mailer_body)  { Capybara.string(mailer.body.encoded) }
      
      it "should deliver successfully" do
        lambda { mailer.deliver }.should_not raise_error
      end
      
      describe "mailer header" do
        it "is sent from 'invites@example.com'" do
          mailer.from.should == ["invites@example.com"]
        end
        
        it "is sent to the invitee" do
          mailer.to.should == [invite.email]
        end
        
        it "has the event's name in the subject" do
          mailer.subject.include?(event.name).should be_true
        end
        
        it "has the event creator's name in the subject" do
          mailer.subject.include?(event.user.name).should be_true
        end
        
        it "has the event's start time in the subject" do
          mailer.subject.include?(event.start_time.to_s).should be_true
        end
      end
      
      describe "mailer body" do
        it "contains the invitee's name" do
          mailer_body.find("#invitee_name").should have_content invite.name
        end
      
        it "contains the invitee's name" do
          mailer_body.find("#event_details").should have_content event.user.name
        end
        
        it "contains the event's name" do
          mailer_body.find("#event_details").should have_content event.name
        end
        
        it "contains the address of the event" do
          mailer_body.find("#event_details").should have_content event.full_address
        end
                
        it "contains the event's start time" do
          mailer_body.find("#event_details").should have_content event.start_time
        end
        
        it "contains links to each of the event's restaurants" do
          event.restaurant_options.each do |ro|
            mailer_body.find("#restaurant_#{ro.id}").should have_content ro.name
          end
        end
      end
    end
  end
end