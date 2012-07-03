class InvitesController < ApplicationController
  before_filter :authenticate_user
  before_filter :find_event
  before_filter :verify_event_owner

  def new
    @event = Event.find params[:event_id]
  end

  def create
    @event = Event.find params[:event_id]
    params[:new_contacts].each do |nc|
      unless nc.last[:name].blank? || nc.last[:name].blank?
        contact = current_user.contacts.create(name: nc.last[:name],
                                               email: nc.last[:email])
        @event.invites.create(contact_id: contact.id)
      end
    end
    redirect_to event_path @event
  end
end