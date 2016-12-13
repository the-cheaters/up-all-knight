require 'rails_helper'

RSpec.describe Piece, type: :model do

  let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

  describe "Bishop#valid_move?(destination_x, destination_y)" do
    let(:bishop) { FactoryGirl.create(:bishop, game_id: game.id, player_id: white_player.id) }

    subject { bishop.valid_move?(destination_x, destination_y) }

    context "invalid move" do
      let(:destination_x) { 3 }
      let(:destination_y) { 7 }

      it "should not allow an invalid move" do
        expect(subject).to eq(false)
      end
    end


    context "up and right" do

      let(:destination_x) { 6 }
      let(:destination_y) { 6 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the bishop is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 5, y_position: 5, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

    end


    context "down and right" do

      let(:destination_x) { 6 }
      let(:destination_y) { 2 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the bishop is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 5, y_position: 3, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

    end


    context "down and left" do

      let(:destination_x) { 2 }
      let(:destination_y) { 2 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the bishop is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 3, y_position: 3, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

    end


    context "up and left" do

      let(:destination_x) { 2 }
      let(:destination_y) { 6 }

      it "should be a valid move" do
        expect(subject).to eq(true)
      end

      it "should return true if the square is occupied by a piece of the opposing color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 6, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

      it "should return false if the square is occupied by a piece of the same color" do
        piece = FactoryGirl.create(:piece, x_position: 2, y_position: 6, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

      it "should return false if the bishop is obstructed" do
        piece = FactoryGirl.create(:piece, x_position: 3, y_position: 5, game_id: game.id, player_id: white_player.id)
        expect(subject).to eq(false)
      end

    end

  end

end
