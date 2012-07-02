class EventsController < ApplicationController
  before_filter :authenticate_user

  def index
    @events = current_user.events
  end

  def show
    @event = Event.find params[:id]
    unless @event.user_id == current_user.id
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new params[:event]
    if @event.save
      redirect_to new_event_schedule_path @event
    else
      render :new
    end
  end
end