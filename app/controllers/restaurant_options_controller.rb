class RestaurantOptionsController < ApplicationController
  before_filter :authenticate_user

  def new
    @event = Event.find params[:event_id]
    @nearby_restaurants = @event.nearby_restaurants
  end

  def create
    @event = Event.find params[:event_id]
    params[:restaurant].keys.each do |restaurant_id|
      option = RestaurantOption.create(restaurant_id: restaurant_id)
      @event.restaurant_options << option
    end
    redirect_to new_event_invite_path @event
  end
end