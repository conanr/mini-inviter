class EventMailer < ActionMailer::Base
  default from: "invites@example.com"
  
  def create_invite invite
    @invite   = invite
    @event    = invite.event
    mail to: invite.email, 
         subject: "#{@event.user.name} invites you to #{@event.name} : #{@event.start_time}"
  end
end