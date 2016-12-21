require 'rails_helper'


RSpec.describe Game, type: :model do


  
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
    let(:game) { FactoryGirl.create(:game, :populated, white_player_id: white_player.id, black_player_id: black_player.id) }
    let(:king) { game.pieces.where(:player_id => black_player.id, :type => "King").last }
    
    it "should initialize all pieces on board." do
      expect(game.pieces.count).to eq(32)
    end
    
    it "should place black kings x_position to 4, y_position to 0 and captured to false" do
      expect(king.x_position).to eq(4)
      expect(king.y_position).to eq(0)
      expect(king.captured).to eq(false)
    end
    
  end

  describe "player's turn" do 
    let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'meow@meow.com', password: 'MONORAILCAT') }
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }
    let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: black_player.id) }

    it "should set the first turn of a player to white" do
      expect(game.current_turn).to eq(white_player.id)
    end
    
    it "should set the current turn to the correct player" do
      expect(game.current_player_turn).to eq('white')
      piece.move_to(5,5)
      game.reload
      expect(game.current_player_turn).to eq('black')
    end

    it "should change turns after player moves" do
      expect(game.current_turn).to eq(white_player.id)
      piece.move_to(5,5)
      game.reload
      expect(game.opponent).to eq(black_player.id) 
    end
  end 
end

