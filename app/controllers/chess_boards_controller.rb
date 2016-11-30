class ChessBoardsController < ApplicationController

  def show

    @chess_board = Piece.piece_display.find_by(:game_id)
    # @chess_board = Chessboard.find(params[:game_id])
    # @game = Game.find(params[:id])
    # @pieces = @game.pieces
    
  end
  

end
