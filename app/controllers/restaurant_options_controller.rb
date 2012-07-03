class RestaurantOptionsController < ApplicationController
  before_filter :authenticate_user
  before_filter :find_event
  before_filter :verify_event_owner

  def new
    @nearby_restaurants = @event.nearby_restaurants.limit 10
  end

  def create
    unless params[:restaurant] && params[:restaurant].keys.count > 1
      redirect_to new_event_restaurant_option_path(@event),
                  :alert => "Please select two or more restaurants."
    else
      params[:restaurant].keys.each do |restaurant_id|
        option = RestaurantOption.create(restaurant_id: restaurant_id)
        @event.restaurant_options << option
      end
      redirect_to new_event_invite_path @event
    end
  end
end