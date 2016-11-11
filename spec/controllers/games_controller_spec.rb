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
      post :create, game: {}
      expect(response).to have_http_status(:success)
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
    it "should update a game" do
      # need more info about the database before writing this
    end
  end

  describe "games#destroy action" do
    it "should destroy a game" do
      game = FactoryGirl.create(:game)
      delete :destroy, id: game.id
      expect(response).to redirect_to root_path
      game = Game.find_by_id(game.id)
      expect(game).to eq nil
    end
  end
  
end
