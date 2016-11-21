require 'rails_helper'

RSpec.describe Timer, type: :model do

  let(:player) { FactoryGirl.create(:player, current_player.id) }

    it "should start timer for current player" do
      FactoryGirl.create(:player, current_player.id)
      expect(timer).to be_valid
    end

    it "should stop timer for current player" do 
      expect(timer).to eq false > 5.minutes
    end

    it "should reset timer for players" do 
      expect(timer).to eq 0
      
    end
end
