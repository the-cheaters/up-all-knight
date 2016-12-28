require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe "Pawn#valid_move?(destination_x, destination_y)" do
      
    let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'blah@cat.com', password: 'ONECAT') }
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
    let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: white_player.id) }
    
    
    subject { pawn.valid_move?(destination_x, destination_y) }
    
    context "valid move for first move" do
      let(:destination_x) { 6 }
      let(:destination_y) { 4 }
      
      it "should return true if the white pawn is moving 2 squares up for first move" do
        expect(subject).to eq(true)
      end
    end

     context "valid move for white player" do
      let(:destination_x) { 6 }
      let(:destination_y) { 5 } 

      it "should return true if the white pawn is moving 1 square up for any move" do 
        expect(subject).to eq(true)
      end
    end

    context "diagonal move for capture" do 
      let(:destination_x) { 5 }
      let(:destination_y) { 5 }

      it "should return false if no piece present" do 
        expect(subject).to eq(false)
      end
    end

    context "diagonal move for capture" do 
      let(:destination_x) { 5 }
      let(:destination_y) { 5 }

      it "should return true if a piece is present and available for capture" do 
        FactoryGirl.create(:pawn, x_position: 5, y_position: 5, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end

    context "invalid move" do
      let(:destination_x) { 4 }
      let(:destination_y) { 3 }
      
      it "should return false if the pawn tries to move outside of its constraints" do
        expect(subject).to eq(false)
      end
    end
  end
  
  describe "Pawn Promotion" do
    let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'blah@cat.com', password: 'ONECAT') }
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
    
    context "White Piece#can_pawn_promote?" do
      let(:pawn) { FactoryGirl.create(:pawn, x_position: 5, y_position: 1, game_id: game.id, player_id: white_player.id) }
      subject { pawn.can_pawn_promote?(destination_y) }
      let(:destination_x) { 5 }
      let(:destination_y) { 0 }
      
      it "should return true" do
        expect(subject).to eq(true)
      end
    end

    context "White Piece#can_pawn_promote?" do
      let(:pawn) { FactoryGirl.create(:pawn, x_position: 5, y_position: 2, game_id: game.id, player_id: white_player.id) }
      subject { pawn.can_pawn_promote?(destination_y) }
      let(:destination_x) { 5 }
      let(:destination_y) { 1 }
      
      it "should return false if not a end of board" do
        expect(subject).to eq(false)
      end
    end

        context "Black Piece#can_pawn_promote?" do
      let(:pawn) { FactoryGirl.create(:pawn, x_position: 5, y_position: 6, game_id: game.id, player_id: black_player.id) }
      subject { pawn.can_pawn_promote?(destination_y) }
      let(:destination_x) { 5 }
      let(:destination_y) { 7 }
      
      it "should return true" do
        expect(subject).to eq(true)
      end
    end

    context "Black Piece#can_pawn_promote?" do
      let(:pawn) { FactoryGirl.create(:pawn, x_position: 5, y_position: 2, game_id: game.id, player_id: black_player.id) }
      subject { pawn.can_pawn_promote?(destination_y) }
      let(:destination_x) { 5 }
      let(:destination_y) { 1 }
      
      it "should return false" do
        expect(subject).to eq(false)
      end
    end
    
    context "Piece#promote_pawn" do
      let(:pawn) { FactoryGirl.create(:pawn, x_position: 5, y_position: 0, game_id: game.id, player_id: white_player.id) }
      
      it "should change pawn type to Queen" do
        pawn.promote_pawn("Queen")
        expect(pawn.type).to eq("Queen")
      end

      it "should change pawn type to Rook" do
        pawn.promote_pawn("Rook")
        expect(pawn.type).to eq("Rook")
      end

      it "should change pawn type to Knight" do
        pawn.promote_pawn("Knight")
        expect(pawn.type).to eq("Knight")
      end

      it "should change pawn type to Bishop" do
        pawn.promote_pawn("Bishop")
        expect(pawn.type).to eq("Bishop")
      end
    end
  end
end
