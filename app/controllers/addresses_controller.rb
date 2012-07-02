class AddressesController < ApplicationController
  before_filter :authenticate_user

  def new
    @event = Event.find params[:event_id]
    @address = Address.new
  end

  def create
    @event = Event.find params[:event_id]
    @event.address = Address.create params[:address]
    redirect_to new_event_restaurant_option_path @event
  end
end