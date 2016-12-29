require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, :populated, white_player_id: white_player.id, black_player_id: black_player.id) }
  let(:king) { game.pieces.where(:player_id => black_player.id, :type => "King").last }
  let(:rook) { FactoryGirl.create(:rook, player_id: white_player.id) }

  describe "is_available" do
    it "should return only games that are available" do
      Game.create("name" => "touchdown", "white_player_id" => 0)
      @games = Game.is_available
      expect(@games.last.name).to eq("touchdown")
    end
  end

  describe "populate_board!" do
    it "should initialize all pieces on board." do
      expect(game.pieces.count).to eq(32)
    end

    it "should place black kings x_position to 4, y_position to 0 and captured to false" do
      expect(king.x_position).to eq(4)
      expect(king.y_position).to eq(0)
      expect(king.captured).to eq(false)
    end
  end

  describe "check?" do
    let(:game) { FactoryGirl.create(:game, white_player: white_player, black_player: black_player) }

    context "the black king" do
      it "should be in check" do
        king = FactoryGirl.create(:king, x_position: 4, y_position: 1, player: black_player, game: game)
        rook = FactoryGirl.create(:rook, x_position: 4, y_position: 7, player: white_player, game: game)
        expect(game.check?(black_player)).to eq (true)
      end

      it "should not be in check" do
        king = FactoryGirl.create(:king, x_position: 4, y_position: 1, player: black_player, game: game)
        rook = FactoryGirl.create(:rook, x_position: 6, y_position: 7, player: white_player, game: game)
        expect(game.check?(black_player)).to eq (false)
      end
    end

    context "the white king" do
      it "should be in check" do
        king = FactoryGirl.create(:king, x_position: 4, y_position: 1, player: white_player, game: game)
        rook = FactoryGirl.create(:rook, x_position: 4, y_position: 7, player: black_player, game: game)
        expect(game.check?(white_player)).to eq (true)
      end

      it "should not be in check" do
        king = FactoryGirl.create(:king, x_position: 4, y_position: 1, player: white_player, game: game)
        rook = FactoryGirl.create(:rook, x_position: 6, y_position: 7, player: black_player, game: game)
        expect(game.check?(white_player)).to eq (false)
      end
    end
  end

  describe "checkmate?" do
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

    it "should be in checkmate if king is currently in check and cannot move out of check" do
      game.check?(black_player) == true
      king = FactoryGirl.create(:king, x_position: 0, y_position: 0, player: black_player, game: game)
      queen = FactoryGirl.create(:queen, x_position: 0, y_position: 1, player: white_player, game: game)
      queen_2 = FactoryGirl.create(:queen, x_position: 1, y_position: 1, player: white_player, game: game)
      expect(game.checkmate?(black_player)).to eq(true)
    end

    it "should have checkmate value equal to false if king is not in check" do
      game.check?(black_player) == false
      expect(game.checkmate?(black_player)).to eq(false)
    end


  end

  describe "game.stalemate?" do

    context "not stalemate" do
      it "should not be stalemate" do
        expect(game.check?(black_player)).to eq(false)
      end
    end

    context "stalemate" do
      let(:g) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

      it "should say that black is in stalemate" do
        black_king = FactoryGirl.create(:king, game_id: g.id, x_position: 0, y_position: 0, moves: 2, player_id: black_player.id)
        white_rook = FactoryGirl.create(:rook, game_id: g.id, x_position: 1, y_position: 1, player_id: white_player.id)
        white_king = FactoryGirl.create(:king, game_id: g.id, x_position: 2, y_position: 2, moves: 2, player_id: white_player.id)
        expect(g.stalemate?(black_player)).to eq(true)
      end
    end
  end

  describe "player's turn" do
    let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }
    let(:black_player) { FactoryGirl.create(:player, id: 101, email: 'meow@meow.com', password: 'MONORAILCAT') }
    let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
    let(:piece) { FactoryGirl.create(:piece, game_id: game.id, player_id: white_player.id) }
    let(:pawn) { FactoryGirl.create(:pawn, game_id: game.id, player_id: black_player.id) }

    it "should set the first turn of a player to white" do
      game.set_default_turn!
      expect(game.current_turn).to eq(white_player.id)
    end

    it "should set the current turn to the correct player" do
      game.set_default_turn!
      expect(game.current_player_turn).to eq('white')
      piece.move_to(5,5)
      game.reload
      expect(game.current_player_turn).to eq('black')
    end

    it "should change turns after player moves" do
      game.set_default_turn!
      expect(game.current_turn).to eq(white_player.id)
      piece.move_to(5,5)
      game.reload
      expect(game.current_turn).to eq(black_player.id)
    end
  end
end
