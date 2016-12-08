require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:white_player) { FactoryGirl.create(:player, id: 212, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, id: 213, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

  describe "Rook#valid_move?(destination_x, destination_y)" do
    let(:rook) { FactoryGirl.create(:rook, game_id: game.id, player_id: white_player.id) }

    subject { rook.valid_move?(destination_x, destination_y) }

    context "invalid move" do
      let(:destination_x) { 6 }
      let(:destination_y) { 7 }

      it "should not allow an invalid move" do
        expect(subject).to eq(false)
      end
    end

    context "up" do
      let(:destination_x) { 4 }
      let(:destination_y) { 8 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 8, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 8, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the rook is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 6, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end
    end

    context "down" do
      let(:destination_x) { 4 }
      let(:destination_y) { 2 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 2, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 2, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the rook is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 4, y_position: 3, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end
    end

    context "right" do
      let(:destination_x) { 8 }
      let(:destination_y) { 4 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 8, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 8, y_position: 4, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the rook is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 6, y_position: 4, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end
    end

    context "left" do
      let(:destination_x) { 2 }
      let(:destination_y) { 4 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 4, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the rook is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 3, y_position: 4, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end
    end

  end

end
