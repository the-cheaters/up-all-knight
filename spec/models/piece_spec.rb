require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

  describe "Piece.move_to(x, y)" do

    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }

    it "should have its x and y position updated when it moves" do
      piece.move_to(5,5)
      piece.reload
      expect(piece.x_position).to eq(5)
    end

    it "should increase the moves count of a new piece by one" do
      piece.move_to(5,5)
      piece.reload
      expect(piece.moves).to eq(1)
    end

    it "should not increase the moves count of a piece by more than two" do
      piece.move_to(5,5)
      piece.move_to(6,6)
      piece.move_to(7,7)
      piece.reload
      expect(piece.moves).to eq(2)
    end
  end

  describe "Piece#game.change_turns" do

    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }

    it "should change turns after a player moves piece" do
      game.set_default_turn!
      expect(game.current_turn).to eq(white_player.id)
      piece.move_to(5,5)
      game.reload
      expect(game.current_turn).to eq(black_player.id)
    end
  end

  describe "Piece.en_passant" do
    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id, x_position: 7, y_position: 2) }
    let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: black_player.id, x_position: 1, y_position: 1) }

    it "should be able to capture a pawn en passant" do
      pawn.move_to(1,3)
      piece.move_to(1,2)
      pawn.reload
      expect(pawn.captured).to eq(true)
    end

    it "should not be able to capture en passant a pawn that has made two moves" do
      pawn.move_to(1,2)
      pawn.move_to(1,3)
      piece.move_to(1,2)
      pawn.reload
      expect(pawn.captured).to eq(false)
    end

    it "should not able to capture a pawn en passant after another piece moves" do
      another_piece = FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id)
      pawn.move_to(1,3)
      another_piece.move_to(5,5)
      piece.move_to(1,2)
      pawn.reload
      expect(pawn.captured).to eq(false)
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
      let(:destination_x) { 2 }
      let(:destination_y) { 2 }
      
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
  
  describe "Knight#valid_move?" do
    
    let(:knight) { FactoryGirl.create(:knight, game_id: game.id, player_id: black_player.id) }
    
    subject { knight.valid_move?(destination_x, destination_y) }
    
    context "valid move" do
      let(:destination_x) { 3 }
      let(:destination_y) { 4 }
      
      it "should return true if the move is valid" do
        expect(subject).to eq(true)
      end
    end
    
    context "invalid move" do
      let(:destination_x) { 7 }
      let(:destination_y) { 7 }
      
      it "should return false if the knight tries to move outside of its constraints" do
        expect(subject).to eq(false)
      end
    end
    
    context "no move" do
      let(:destination_x) { 5 }
      let(:destination_y) { 5 }
      
      it "should return false if the knight tries to move on top of itself" do
        expect(subject).to eq(false)
      end
    end
    
  end
  
  describe 'a Knight' do
    it 'should be a Knight' do
      knight = FactoryGirl.create(:knight, player_id: black_player.id)
      expect(knight.type).to eq 'Knight'
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
  
  describe 'unicode_symbol to change pieces color' do
    
    it "should return true for WHITE piece" do
      game = Game.create(white_player_id: 0, black_player_id: 1)
      pawn = Pawn.create(x_position: 0, y_position: 1, game_id: game.id, player_id: 0)
      expect(pawn.unicode_symbol).to eq "&#9817;"
    end
    
    it "should return true for BLACK piece" do
      game = Game.create(white_player_id: 0, black_player_id: 1)
      pawn = Pawn.create(x_position: 0, y_position: 1, game_id: game.id, player_id: 1)
      expect(pawn.unicode_symbol).to eq "&#9823;"
    end
  end
  
end
