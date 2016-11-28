class EnrollmentsController < ApplicationController
  before_action :authenticate_player!

  def create
    current_player.join_game(@current_game)
  end

  private

  def current_game
    @current_game ||= Game.is_available.find(params[:game_id])
  end
end
