class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!, only: [:show, :new, :create, :update, :destroy, :add_player, :draw, :reject_draw, :forfeit]
  
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
    set_user_color
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
    @game.current_turn = 0
    @game.black_player_id = current_player.id if @game.white_player_id == 0

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
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
    redirect_to game_path
  end

  def message
  end
  
  private

  def set_user_color
    if current_player.id == @game.black_player_id
      @color = :black
    elsif current_player.id == @game.white_player_id
      @color = :white
    else
      @color = nil
    end
  end

  def set_opponent_id
    if current_player.id == @game.black_player_id
      @opponent_id = @game.white_player_id
    elsif current_player.id == @game.white_player_id
      @opponent_id = @game.black_player_id
    end
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    if params[:id].nil?
      @game ||= Game.find(params[:game_id])
    else
      @game ||= Game.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:current_turn, :white_player_id, :is_blitz, :black_draw, :white_draw, :black_forfeit, :white_forfeit)
  end

end
