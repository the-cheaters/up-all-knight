require 'rails_helper'

RSpec.describe Piece, type: :model do

  let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: black_player.id) }
  let(:piece) { FactoryGirl.create(:piece, x_position: 4, y_position: 4, game_id: game.id, player_id: white_player.id) }

  describe 'a Pawn' do
    it 'should be a pawn' do
      pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 1, game_id: game.id, player_id: black_player.id)
      expect(pawn.type).to eq 'Pawn'
    end
  end

end
