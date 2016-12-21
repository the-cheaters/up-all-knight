class PusherController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def auth
    
    if current_player && params[:channel_name] == "private-user_#{current_player.id}"
      render :json => Pusher[params[:channel_name]].authenticate(params[:socket_id])
    else
      render :text => "Not authorized", :status => '403'
    end
  end
  
end
