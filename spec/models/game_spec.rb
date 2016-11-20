require 'rails_helper'

RSpec.describe Piece, type: :model do
  
end

RSpec.describe Game, type: :model do
  
  describe "is_available" do
    
    it "should return only games that are available" do
      Game.create("name" => "touchdown", "white_player_id" => 0)
      @games = Game.all.is_available
      expect(@games.last.name).to eq("touchdown")
    end
  end
end
