require 'rails_helper'

RSpec.describe Piece, type: :model do

  let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
  let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: white_player.id) }

  describe "Piece#is_obstructed?" do

    subject { piece.is_obstructed?(destination_x, destination_y) }

    context "up" do
      let(:destination_x) { 4 }
      let(:destination_y) { 7 }

      it "should return false if it's not vertically blocked" do
        expect(subject).to eq(false)
      end

      it "should return true if it's vertically blocked" do
        FactoryGirl.create(:piece, x_position: 4, y_position: 6, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

    end

    context "down" do
      let(:destination_x) { 4 }
      let(:destination_y) { 0 }

      it "should return false if it's not vertically blocked" do
        expect(subject).to eq(false)
      end

      it "should return true if it's vertically blocked" do
        FactoryGirl.create(:piece, x_position: 4, y_position: 1, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end

    end

    context "right" do
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
      let (:destination_x) { 0 }
      let (:destination_y) { 4 }

      it "should return false if it's not horizontally blocked" do
        expect(subject).to eq(false)
      end

      it "should return true if it's horizontally blocked" do
        FactoryGirl.create(:piece, x_position: 1, y_position: 4, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end

    context "up and right" do
      let (:destination_x) { 7 }
      let (:destination_y) { 7 }

      it "should return false if it's not diagonally blocked" do
        expect(subject).to eq(false)
      end

      it "should return true if it's diagonally blocked" do
        FactoryGirl.create(:piece, x_position: 6, y_position: 6, game_id: game.id, player_id: black_player.id)
        expect(subject).to eq(true)
      end
    end

  end
  
end
