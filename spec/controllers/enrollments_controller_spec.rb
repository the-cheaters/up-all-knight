require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: 0) }

  describe 'enrollments#create' do
    it 'should successfully enroll a player in a game' do
      game = FactoryGirl.create(:game, white_player_id: white_player.id, black_player_id: 0)
      player = FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT')
      sign_in player
      post :create, :game_id => game.id
      expect(response).to have_http_status(:success)
    end
  end

end
