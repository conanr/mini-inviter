class SchedulesController < ApplicationController
  before_filter :authenticate_user
  
  def new
    @event = Event.find params[:event_id]
    @schedule = Schedule.new
  end
  
  def create
    @event = Event.find params[:event_id]
    @event.schedule = Schedule.create params[:schedule]
    redirect_to new_event_address_path @event
  end
end