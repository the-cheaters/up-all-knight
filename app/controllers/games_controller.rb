class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  
  attr_accessor :name
  
  def name
    "Game #{self.id}"
  end
  
  # GET /games
  # GET /games.json
  def index
    @games = Game.is_available
  end
  
  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @white_player_timer = @game.timers.where(:player_id => @game.white_player_id).last
    @black_player_timer = @game.timers.where(:player_id => @game.black_player_id).last
  end
  
  # GET /games/new
  def new
    @game = Game.new
  end
  
  # GET /games/1/edit
  def edit
  end
  
  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.black_player_id = current_player.id if @game.white_player_id == 0
    if @game.save && @game.is_blitz
      @game.create_timers(params[:time_left])
    end
    redirect_to game_path(@game)
  end
  
  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @game.destroy
    redirect_to root_path
  end
  
  def add_player
    set_game
    current_player.join_game!(@game)
    @game.update_timer(current_player)
    redirect_to game_path
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:current_turn, :white_player_id, :is_blitz, :time_left)
  end
  
end
