class ChessBoardsController < ApplicationController

  def show

     @game = Game.find(params[:id])
     @pieces = @game.pieces
    
  end
  

end
