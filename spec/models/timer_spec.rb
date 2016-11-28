require 'rails_helper'

RSpec.describe Timer, type: :model do
  before(:each) do 
    timer = Timer.new
  end

  let(:player) { FactoryGirl.create(:player, email: 'pam@rook.com', password: 'BESTKITTY') }
  let(:game) { FactoryGirl.create(:game, game.id)}
  let(:timer) { FactoryGirl.create(:timer, player_id: player.id)}

    it "should determine when a player starts" do 
      expect(DateTime.new).to be_a(DateTime)
    end

    it "should determine how much time the players have" do
      @time_left = 500
      expect(@time_left).to eq(500)
    end
    
    it "should start timer for current players" do
      expect(timer.start).to eq(Time.now.round(0))
    end

    it "should stop timer for current players" do 
      timer.start
      expect(timer.stop).to eq(Time.now.round(0))
    end

    it "should have multiple starts and stops for players during a game" do 
      expect(timer.start).to eq(Time.now.round(0))
      timer.stop
      expect(timer.start).to eq(Time.now.round(0))
      timer.stop
    end

    it "should end game for a player" do 
      expect(@time_left).to eq nil
    end
end
