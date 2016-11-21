require 'rails_helper'

RSpec.describe Timer, type: :model do

  let(:player) { FactoryGirl.create(:player, current_player.id, email: 'pam@rook.com', password: 'BESTKITTY') }
  let(:game) { FactoryGirl.create(:game, game.id)}

    it "should determine how much time each player has" do 
      expect(Time.new).to be_a(Time)
    end

    it "should start timer for current players" do
      expect(@start_time).to eq(Time.now)
    end

    it "should stop timer for current players" do 
      expect(@stop_time).to eq(Time.now)
    end

    it "should end game for a player" do 
      expect(@time_left).to eq nil
    end
end