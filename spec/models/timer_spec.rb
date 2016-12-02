require 'rails_helper'

RSpec.describe Timer, type: :model do
  
  let(:player) { FactoryGirl.create(:player, email: 'pam@rook.com', password: 'BESTKITTY') }
  let(:game) { FactoryGirl.create(:game, game.id)}
  let(:timer) { FactoryGirl.create(:timer, time_left: 500, player_id: player.id)}

    it "should determine how much time the players have" do
      expect(timer.time_left).to eq(500)
    end
    
    it "should start timer for current players" do 
      now = Time.now.round(0)
      timer.start! 
      expect(timer.start_time.round(0)).to eq(now)
    end

    it "should stop timer for current players" do 
      timer.start!
      timer.stop!
      expect(timer.running).to eq(false)
    end

    it "should have multiple starts and stops for players during a game" do 
      timer.start!
      expect(timer.running).to eq(true) 
      timer.stop!
      expect(timer.running).to eq(false)
      timer.start!
      expect(timer.running).to eq(true)
      timer.stop!
      expect(timer.running).to eq(false)
    end
end
