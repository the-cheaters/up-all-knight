require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  
  describe "games#index action" do
    it "should show the index page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#new action" do
    it "should show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#create action" do
    it "should create a new game in the database" do
      count = Game.count
      post :create, game: { current_turn: 0 }
      expect(Game.count).to eq(count + 1)
    end
    
    it "should create a new game in the database if in json format" do
      count = Game.count
      post :create, format: :json, game: { current_turn: 0 }
      expect(Game.count).to eq(count + 1)
    end
    
    let(:player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
    
    it "should make the current player white if 'white player' is selected" do
      sign_in player
      post :create, game: { white_player_id: player.id }
      game = Game.last
      expect(game.white_player_id).to eq(player.id)
    end
    
    it "should make the current player black if 'black player' is selected" do
      sign_in player
      post :create, game: { white_player_id: 0 }
      game = Game.last
      expect(game.black_player_id).to eq(player.id)
    end
    
    it "should create timers for each player" do
      player = FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT')
      sign_in player
      post :create, game: { white_player_id: 0 }
      @game = Game.last
      expect(@game.timers.count).to eq(2)
      
    end
  end
  
  describe "games#show action" do
    it "should show a game" do
      game = FactoryGirl.create(:game)
      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#update action" do
    it "should update a game in the database" do
      game = FactoryGirl.create(:game)
      patch :update, id: game.id, game: { current_turn: 1 }
      game.reload
      expect(game.current_turn).to eq(1)
    end
    
    it "should update a game in the database if in json format" do
      game = FactoryGirl.create(:game)
      patch :update, id: game.id, format: :json, game: { current_turn: 1 }
      game.reload
      expect(game.current_turn).to eq(1)
    end
  end
  
  describe "games#joingame action" do
    
    context "white player is free" do
      it "should update the white player with the current player" do
        game = FactoryGirl.create(:game, white_player_id: 0)
        player = FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT')
        sign_in player
        player.join_game!(game)
        game.reload
        expect(game.white_player_id).to eq(player.id)
      end
    end
    
    context "black player is free" do
      it "should update the black player with the current player" do
        game = FactoryGirl.create(:game, black_player_id: 0)
        player = FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT')
        sign_in player
        player.join_game!(game)
        game.reload
        expect(game.black_player_id).to eq(player.id)
      end
    end
  end
  
  describe "games#destroy action" do
    it "should destroy a game in the database" do
      game = FactoryGirl.create(:game)
      delete :destroy, id: game.id
      game = Game.find_by_id(game.id)
      expect(game).to eq nil
    end
  end
  
end
