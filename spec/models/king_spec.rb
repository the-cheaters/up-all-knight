require 'rails_helper'

RSpec.describe King, type: :model do
  let(:white_player) { FactoryGirl.create(:player, id: 212, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, id: 213, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }

  describe "king#can_castle?(destination_x, destination_y)" do 

    it 'should return false if the king trying to castle has already moved' do 
      king = King.create(x_position: 4, y_position: 4, game_id: game.id)
      rook = Rook.create(x_position: 7, y_position: 0, game_id: game.id)
      king.move_to(3,0)
      king.move_to(4,0)
      expect(king.valid_move?(6,0)).to eq(false)
    end
    #  HAVE TO WAIT FOR CHECK? METHOD

    # it 'should return false if king tries to castle when in check? or moving toward check?' do 
    #   king = King.create(x_position: 4, y_position: 0, game_id: game.id, black_player_id: black_player.id)
    #   piece = Piece.create(destination_x: 6, destination_y: 0, game_id: game.id, white_player_id: white_player.id)
    #   king.move_to(6, 0)
    #   expect(king.move_to).to eq(false)
    # end

    it 'should move king 2 spaces if king can castle queenside' do 
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      king.move_to(3,0)
      king.move_to(2,0)
      rook.move_to(1,0)
      expect(king.x_position).to eq (2)
    end

    it 'should return true is_obstructed? if king attempts castle kingside and bishop is present' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 7, y_position: 0, game_id: game.id, player_id: black_player.id)
      bishop = Bishop.create(x_position: 5, y_position: 0, game_id: game.id)
      expect(king.is_obstructed?(6,0)).to eq (true)
    end

    it 'should return true is_obstructed? if king attempts to castle kingside and knight is present' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 7, y_position: 0, game_id: game.id, player_id: black_player.id)
      knight = Knight.create(x_position: 6, y_position: 0, game_id: game.id)
      king.move_to(5,0)
      king.move_to(6,0)
      expect(king.is_obstructed?(6,0)).to eq (true)
    end

    it 'should return true is_obstructed? if kings attempts to castle queenside and bishop is present' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      bishop = Bishop.create(x_position: 2, y_position: 0, game_id: game.id)
      king.move_to(3,0)
      king.move_to(2,0)
      expect(king.is_obstructed?(2,0)).to eq (true)
    end

    it 'should return true is_obstructed? if king attempts to castle queenside and knight is present' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      knight = Knight.create(x_position: 1, y_position: 0, game_id: game.id)
      king.move_to(2,0)
      rook.move_to(1,0)
      expect(rook.is_obstructed?(1,0)).to eq (true)
    end

    it 'should return false if trying to castle queenside and queen present' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      queen = Queen.create(x_position: 3, y_position: 0, game_id: game.id, player_id: black_player.id)
      expect(king.is_obstructed?(2,0)).to eq (true)
    end

    it 'should not move king if king attempts to castle kingside and 7 rook has been moved' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 7, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook.move_to(6,0)
      rook.move_to(7,0)
      expect(king.x_position).to eq (4)
    end

    it 'should not move king if king attempts to castle queenside and 0 rook has been moved' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 7, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook.move_to(1,0)
      rook.move_to(0,0)
      expect(king.x_position).to eq (4)
    end
  end

  describe "king#castle!(destination_x, destination_y)" do
   #let(:king) {FactoryGirl.create(:king, game_id: game.id, player_id: white_player.id) }
  
    it 'should move the correct rook to correct position when castling kingside' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      rook_2 = Rook.create(x_position: 7, y_position: 0, game_id: game.id, player_id: black_player.id)
      byebug
      king.move_to(6,0)
      rook_2.reload
      byebug
      expect(rook_2.x_position).to eq(5)
    end

    it 'should move the correct rook to correct position when castling queenside' do
      king = King.create(x_position: 4, y_position: 0, game_id: game.id)
      rook = Rook.create(x_position: 0, y_position: 0, game_id: game.id, player_id: black_player.id)
      king.move_to(2,0)
      rook.reload
      expect(rook.x_position).to eq(3)
    end
  end
end
