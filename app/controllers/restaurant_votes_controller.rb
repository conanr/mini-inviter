class RestaurantVotesController < ApplicationController
  def show
    @restaurant_vote = RestaurantVote.find(params[:id])
  end
  
  def create
    invite  = Invite.find(params[:invite_id])
    option  = RestaurantOption.find(params[:option_id])
    @vote   = RestaurantVote.create(invite_id: invite.id, 
                                    restaurant_option_id: option.id)
    unless @vote.errors
      redirect_to event_restaurant_option_restaurant_vote_path(
                    build_path_params(invite, option, @vote))
    else
      redirect_to root_path
    end
  end
  
  private
  
  def build_path_params(invite, option, vote)
    params = {}
    params[:event_id] = invite.event.id
    params[:restaurant_option_id] = option.id
    params[:id] = vote.id
    params
  end
end