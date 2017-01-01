class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :null_session
  def default_url_options
    { host: request.host_with_port }
  end
  # Use callbacks to share common setup or constraints between actions.

  def set_opponent_id
    if current_player.id == @game.black_player_id
      @opponent_id = @game.white_player_id
    elsif current_player.id == @game.white_player_id
      @opponent_id = @game.black_player_id
    else
      @opponent_id = nil
    end
  end

  def set_game
    if params[:id].nil?
      @game ||= Game.find(params[:game_id])
    else
      @game ||= Game.find(params[:id])
    end
  end
  
end
