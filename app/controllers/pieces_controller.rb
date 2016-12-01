class PiecesController < ApplicationController

  def update
  end

  private

  def piece_params
    params.require(:piece).permit(:game_id, :player_id, :piece_id, :new_x_destination, :new_y_destination)
  end

end
