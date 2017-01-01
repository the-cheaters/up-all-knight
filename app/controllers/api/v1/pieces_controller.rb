class Api::V1::PiecesController < Api::V1::BaseController 
  def index
    @game = Game.find(params[:game])
    respond_with @game.pieces
  end
end
