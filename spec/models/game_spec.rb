require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  describe "is_available" do
    
    it "should return only games that are available" do
      Game.create("name" => "touchdown", "white_player_id" => 0)
      @games = Game.is_available
      expect(@games.last.name).to eq("touchdown")
    end
  end
  
  
end

RSpec.describe Game, type: :model do
  
  describe "populate_board!" do
    let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
    
    it "should initialize all pieces on board." do
      expect(game.pieces.count).to eq(32)
    end
    
  end
  
  
end
