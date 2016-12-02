require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

  describe "Queen#valid_move?(destination_x, destination_y)" do
    let(:queen) { FactoryGirl.create(:queen, game_id: game.id, player_id: white_player.id) }

    subject { queen.valid_move?(destination_x, destination_y) }

    # shared examples

    context "north" do

      let(:destination_x) { 4 }
      let(:destination_y) { 5 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return false if the queen is obstructed" do
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 5, game_id: game.id, player_id: white_player.id)

      end

    end

  end

  describe "Piece#capture!" do
    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }
    
    it "should fail if there is no piece to capture" do
      expect { piece.capture_piece(5,4) }.to raise_error(RuntimeError)
    end
    
    it "should fail if the piece is the same color" do
      piece_to_capture = FactoryGirl.create(:piece, x_position: 5, y_position: 4, game_id: game.id, player_id: white_player.id)
      expect { piece.capture_piece(5,4) }.to raise_error(RuntimeError)
    end
    
    it "should update the attributes of a captured piece" do
      piece.capture!
      expect(piece.captured).to eq(true)
    end
    
    it "should capture a piece of the opposite color that exists on the correct coordinates" do
      piece_to_capture = FactoryGirl.create(:piece, x_position: 5, y_position: 4, game_id: game.id, player_id: black_player.id)
      piece.capture_piece(5,4)
      piece_to_capture.reload
      expect(piece_to_capture.captured).to eq(true)
    end
  end
  
  describe "King#valid_move?" do
    
    let(:king) { FactoryGirl.create(:king, game_id: game.id, player_id: black_player.id) }
    
    subject { king.valid_move?(destination_x, destination_y) }
    
    context "valid move" do
      let(:destination_x) { 5 }
      let(:destination_y) { 5 }
      
      it "should return true if the move is valid" do
        expect(subject).to eq(true)
      end
    end
    
    context "invalid move" do
      let(:destination_x) { 7 }
      let(:destination_y) { 7 }
      
      it "should return false if the king tries to move too far" do
        expect(subject).to eq(false)
      end
    end
    
    context "no move" do
      let(:destination_x) { 4 }
      let(:destination_y) { 4 }
      
      it "should return false if the king tries to move on top of itself" do
        expect(subject).to eq(false)
      end
    end
    
  end
  
  describe 'a King' do
    it 'should be a King' do
      king = FactoryGirl.create(:king, player_id: black_player.id)
      expect(king.type).to eq 'King'
    end
  end
  
  describe 'a Pawn' do
    
    let(:pawn) { FactoryGirl.create(:pawn, x_position: 2, y_position: 1, game_id: game.id, player_id: black_player.id) }
    
    it 'should be a pawn' do
      pawn = FactoryGirl.create(:pawn, player_id: black_player.id)
      expect(pawn.type).to eq 'Pawn'
    end
  end
  
  describe "Piece#valid_move?" do
    
    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }
    
    subject { piece.valid_move?(7, 4) }
    
    it "should return true if the piece is not obstructed" do
      expect(subject).to eq(true)
    end
    
    it "should return false if the piece is obstructed" do
      FactoryGirl.create(:piece, x_position: 6, y_position: 4, game_id: game.id, player_id: black_player.id)
      expect(subject).to eq(false)
    end
    
    it "should return false if a piece of the same color is occupying the destination" do
      FactoryGirl.create(:piece, x_position: 7, y_position: 4, game_id: game.id, player_id: white_player.id)
      expect(subject).to eq(false)
    end
    
  end
  
  describe "Piece#is_obstructed?" do
    
    context "up" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 3, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let(:destination_x) { 4 }
      let(:destination_y) { 5 }
      
      it "should return false if it's not vertically blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's vertically blocked" do
        FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "down" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 5, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let(:destination_x) { 4 }
      let(:destination_y) { 2 }
      
      it "should return false if it's not vertically blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's vertically blocked" do
        FactoryGirl.create(:piece, x_position: 4, y_position: 3, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "right" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 7 }
      let (:destination_y) { 4 }
      
      it "should return false if it's not horizontally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's horizontally blocked" do
        FactoryGirl.create(:piece, x_position: 6, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "left" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 0 }
      let (:destination_y) { 4 }
      
      it "should return false if it's not horizontally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's horizontally blocked" do
        FactoryGirl.create(:piece, x_position: 2, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "up and right" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 3, y_position: 3, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 5 }
      let (:destination_y) { 5 }
      
      it "should return false if it's not diagonally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's diagonally blocked" do
        FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "up and left" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 3, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 2 }
      let (:destination_y) { 5 }
      
      it "should return false if it's not diagonally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's diagonally blocked" do
        FactoryGirl.create(:piece, x_position: 3, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "down and right" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 5, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 6 }
      let (:destination_y) { 3 }
      
      it "should return false if it's not diagonally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's diagonally blocked" do
        FactoryGirl.create(:piece, x_position: 5, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
    context "down and left" do
      let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: white_player.id) }
      subject { piece.is_obstructed?(destination_x, destination_y) }
      let (:destination_x) { 2 }
      let (:destination_y) { 2 }
      
      it "should return false if it's not diagonally blocked" do
        expect(subject).to eq(false)
      end
      
      it "should return true if it's diagonally blocked" do
        FactoryGirl.create(:piece, x_position: 3, y_position: 3, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end
    
  end
  
end
