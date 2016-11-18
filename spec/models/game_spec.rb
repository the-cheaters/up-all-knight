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
      @game = Game.create("name" => "touchdown", "available" => true)
      @games = Game.all.is_available
      expect(@game.name).to eq("touchdown")
    end
  end
end
