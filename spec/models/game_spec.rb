require 'rails_helper'

RSpec.describe Piece, type: :model do
  
end

RSpec.describe Game, type: :model do
  describe "is_available" do
    it "should return default value" do
      game = FactoryGirl.create(:game)
      expect(game.available).to eq(true)
    end
  end
  describe "is_available" do
    it "should return false" do
      game = FactoryGirl.create(:game)
      game.available = false
      expect(game.available).to eq(false)
    end
  end
  describe "is_available" do
    
    it "should return only games that are available" do
      Game.create("name" => "touchdown", "black_player_id" => 1)
      @games = Game.all.is_available
      expect(@games.last.name).to eq("touchdown")
    end
  end
end
