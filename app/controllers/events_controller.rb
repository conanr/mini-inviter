class EventsController < ApplicationController
  before_filter :authenticate_user
  
  def index
  end
  
  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.create params[:event]
    redirect_to new_event_schedule_path @event
  end
  
#   def show_step_1
#   end
#   
#   def process_step_1
#     # .replace on the start_date value returned method not found(?)
#     # so processing here for now
#     event_time = params['start_date'].sub('00:00:00', params['start_time'])
#     session[:event_info][:start_time] = event_time
#     redirect_to step_2_path
#   end
#   
#   def show_step_2
#   end
#   
#   def process_step_2
#     redirect_to step_3_path
#   end
#   
#   def show_step_3
#   end
#   
#   def process_step_3
#     redirect_to step_4_path
#   end
#   
#   def show_step_4
#   end
end