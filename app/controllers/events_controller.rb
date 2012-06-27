class EventsController < ApplicationController
  before_filter :authenticate_user
  before_filter :get_event_info, only: [:show_step_1, :show_step_2, :show_step_3, :show_step_4]
  
  def index
  end
  
  def show
  end
  
  def create
  end
  
  def show_step_1
    session[:event_info] = {}
    session[:event_info][:user_id] = current_user.id
  end
  
  def process_step_1
    # .replace on the start_date value returned method not found(?)
    # so processing here for now
    event_time = params['start_date'].sub('00:00:00', params['start_time'])
    session[:event_info][:start_time] = event_time
    redirect_to step_2_path
  end
  
  def show_step_2
  end
  
  def process_step_2
    redirect_to step_3_path
  end
  
  def show_step_3
  end
  
  def process_step_3
    redirect_to step_4_path
  end
  
  def show_step_4
  end
  
  private
  
  def get_event_info
    @event_time  = display_event_time
    @event_place = "My House"
  end
  
  def display_event_time
    if session[:event_info][:start_time]
      Time.parse(session[:event_info][:start_time]).strftime('%F %r')
    else
      "-"
    end
  end
end