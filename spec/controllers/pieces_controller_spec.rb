require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  let(:white_player) { FactoryGirl.create(:player, email: 'blah@blah.com', password: 'SPACECAT') }
  let(:black_player) { FactoryGirl.create(:player, email: 'meow@meow.com', password: 'MONORAILCAT') }
  let(:game) { FactoryGirl.create(:game,:populated, white_player_id: white_player.id, black_player_id: black_player.id) }
  let(:knight) { FactoryGirl.create(:knight, game_id: game.id,x_position: 4, y_position: 4 ) }
  
  
  it "has a 200 status code" do
    patch :update, game_id: game.id, id: knight.id , piece: { x_position: '2', y_position: '3' }
    expect(response.code).to eq('200')
  end
  
  it "has a 422 status code" do
    patch :update, game_id: game.id, id: knight.id , piece: { x_position: '2', y_position: '4' }
    expect(response.code).to eq('422')
  end
  
  it "has a 422 status code if passing nil" do
    patch :update, game_id: game.id, id: knight.id , piece: { x_position: nil, y_position: nil }
    expect(response.code).to eq('422')
  end
end
