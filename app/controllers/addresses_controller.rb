class AddressesController < ApplicationController
  before_filter :authenticate_user
  before_filter :find_event
  before_filter :verify_event_owner

  def new
    @address = Address.new
  end

  def create
    @event.build_address params[:address]
    if @event.address.save
      redirect_to new_event_restaurant_option_path @event
    else
      @address = @event.address
      render :new
    end
  end
end