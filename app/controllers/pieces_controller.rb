class PiecesController < ApplicationController
  before_action :set_game, :set_opponent_id
  def update
    @original_x = selected_piece.x_position
    @original_y = selected_piece.y_position
    @destination_x = params[:piece][:x_position].to_i
    @destination_y = params[:piece][:y_position].to_i
    if selected_piece.move_to(@destination_x,@destination_y)
      if selected_piece.can_pawn_promote?(@destination_y)
         Pusher["private-user_#{current_player.id}"].trigger!('pawn-promotion', {
        pawnPromotionUpdateURL: game_piece_promote_pawn_path(@game, selected_piece.id), message: "You made it to the other side! Click one of the buttons to pick your new piece."
      })
      end
      if !selected_piece.game.has_started
        selected_piece.game.has_started = true
        selected_piece.game.save
        Pusher["broadcast_#{@game.id}"].trigger!('start_game', {
          has_started: true })
      end
        Pusher["private-user_#{@opponent_id}"].trigger!('move_piece_onscreen', {
          piece: {original_x: @original_x, original_y: @original_y, destination_x: @destination_x, destination_y: @destination_y}, event: params[:event]})
      if selected_piece.game.is_blitz
        @white_timer = selected_piece.game.timers.where(player_id: selected_piece.game.white_player_id).last
        @black_timer = selected_piece.game.timers.where(player_id: selected_piece.game.black_player_id).last
        if selected_piece.game.current_turn == selected_piece.game.black_player_id
          @black_timer.start!
          @white_timer.stop!
        else
          @white_timer.start!
          @black_timer.stop!
        end
        Pusher["broadcast_#{@game.id}"].trigger!('change_turns',{timer: {white_start_time: @white_timer.start_time, black_start_time: @black_timer.start_time, black_time_left: @black_timer.time_left,white_time_left: @white_timer.time_left}, current_turn: selected_piece.game.current_player_turn })
        render json: {}, status: :ok
      else
        Pusher["broadcast_#{@game.id}"].trigger!('change_turns',{ current_turn: selected_piece.game.current_player_turn })
        render json: {}, status: :ok
      end
    else
      render json: {response: {error: 'Invalid Move'}}, status: :unprocessable_entity
    end

    if @opponent_id != (nil || 0)
      if @game.check?(Player.where(id: @opponent_id).take)
        Pusher["private-user_#{@opponent_id}"].trigger!('message', {
          :message => "You are in check."
        })
      elsif @game.check?(Player.where(id: current_player.id).take)
        Pusher["private-user_#{current_player.id}"].trigger!('message', {
          :message => "You are in check."
        })
      end

      if @game.checkmate?(Player.where(id: @opponent_id).take)
        Pusher["private-user_#{@opponent_id}"].trigger!('message', {
          :message => "You are in checkmate!"
        })
      elsif @game.checkmate?(Player.where(id: current_player.id).take)
        Pusher["private-user_#{current_player.id}"].trigger!('message', {
          :message => "You are in checkmate!"
        })
      end
    end
  end

  def promote_pawn
    selected_piece.promote_pawn(params[:new_piece])
    Pusher["private-user_#{current_player.id}"].trigger!('pawn-promotion-choosen', {})
    render json: {}
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position,:y_position)
  end

  def selected_piece
    if params[:id].nil?
    @selected_piece ||= Piece.find(params[:piece_id])
    else
    @selected_piece ||= Piece.find(params[:id])
    end
  end

  def set_game
    @game ||= Game.find(params[:game_id])
  end

end
