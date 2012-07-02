class EventMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "invites@example.com"

  def create_invite invite
    @invite   = Invite.find(invite['id'])
    @event    = Event.find(@invite.event.id)

    mail to: @invite.email,
         subject: "#{@event.user.name} invites you to " +
                  "#{@event.name} : #{@event.start_time}"
  end
end