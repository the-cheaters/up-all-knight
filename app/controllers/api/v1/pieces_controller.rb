class Api::V1::PiecesController < Api::V1::BaseController 
  
  def index
    respond_with @game.pieces
  end
end
