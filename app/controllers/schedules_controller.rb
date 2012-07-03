class SchedulesController < ApplicationController
  before_filter :authenticate_user
  before_filter :find_event
  before_filter :verify_event_owner

  def new
    @schedule = Schedule.new
  end

  def create
    @event.build_schedule params[:schedule]
    if @event.schedule.save
      redirect_to new_event_address_path @event
    else
      @schedule = @event.schedule
      render :new
    end
  end
end