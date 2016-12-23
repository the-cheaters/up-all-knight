class PiecesController < ApplicationController
  
  def update
    if selected_piece.move_to(params[:piece][:x_position].to_i,params[:piece][:y_position].to_i)
      Pusher['broadcast'].trigger!('move_piece_onscreen', {
        symbol: selected_piece.unicode_symbol, destination_x: params[:piece][:x_position].to_i, destination_y: params[:piece][:y_position].to_i, x_position: selected_piece.x_position, y_position: selected_piece.x_position
        })
        render json: {}, status: :ok
      else
        render json: {response: {error: 'Invalid Move'}}, status: :unprocessable_entity
      end
    end
    
    private
    
    def piece_params
      params.require(:piece).permit(:x_position,:y_position)
    end
    
    def selected_piece
      @selected_piece ||= Piece.find(params[:id])
    end
  end
  