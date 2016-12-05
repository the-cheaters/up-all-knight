require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe "Pawn#valid_move?(destination_x, destination_y)" do
      
      let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
      let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'blah@cat.com', password: 'ONECAT') }
      let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
      let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: white_player.id) }
      let(:king) { FactoryGirl.create(:king, x_position: 2, y_position: 2, game_id: game.id, player_id: black_player.id) }
      
      
      subject { pawn.valid_move?(destination_x, destination_y) }
      
      context "valid move for first move" do
        let(:destination_x) { 1 }
        let(:destination_y) { 3 }
        
        it "should return true if the white pawn is moving 2 squares up for first move" do
          expect(subject).to eq(true)
        end
      end

       context "valid move for any move" do
        let(:destination_x) { 1 }
        let(:destination_y) { 2 } 

        it "should return true if the white pawn is moving 1 square up for any move" do 
          expect(subject).to eq(true)
        end
      end

        context "diagonal move for capture" do 
          let(:destination_x) { 2 }
          let(:destination_y) { 2 }

          it "should return false if no piece present" do 
            expect(subject).to eq(false)
          end
        end

        context "diagonal move for capture" do 
          let(:destination_x) { 2 }
          let(:destination_y) { 2 }

          it "should return true if a piece is present" do 
            FactoryGirl.create(:pawn, x_position: 2, y_position: 2, player_id: black_player.id)
            # Piece.create(type: pawn, x_position: 2, y_position: 2, player_id: black_player.id)
            expect(subject).to eq(true)
          end
        end

      #   context "valid move for promotion" do
      #   let(:destination_x) { 6 }
      #   let(:destination_y) { 7 } 

      #   it "should return true if the white pawn moves to last row" do 
      #     expect(subject).to eq(true)
      #   end
      # end
      
        context "invalid move" do
          let(:destination_x) { 4 }
          let(:destination_y) { 3 }
          
          it "should return false if the pawn tries to move outside of its constraints" do
            expect(subject).to eq(false)
          end
        end
     
      
    end
  end
