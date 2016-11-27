class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_available_game.add_player(current_user)
    current_available_game.save
  end

  def add_player
    current_user.enrollments.create(game: current_available_game)
  end

  private

  def current_available_game
    @current_available_game ||= Game.is_available.find(params[:id])
  end
end
