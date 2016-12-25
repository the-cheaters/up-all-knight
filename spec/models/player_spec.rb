require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'from_omniauth' do

    context 'Find' do

      it "should be true" do
        auth = FactoryGirl.create(:auth_hash, :facebook)
        FactoryGirl.create(:player)
        expect { Player.from_omniauth(auth) }.to_not change{ Player.count }
      end

    end
    context 'create' do


      let(:auth) { FactoryGirl.create(:auth_hash, :facebook) }


      it "player count increases by 1" do
        expect { Player.from_omniauth(auth) }.to change{ Player.count }.by(1)
      end

      it "should return correct player" do

        player = Player.from_omniauth(auth)
        expect(player.provider).to eq(auth.provider)
        expect(player.uid).to eq(auth.uid.to_s)
        expect(player.email).to eq(auth.info.email)
      end
    end
  end

  describe "player.add_win!" do

    context "end game" do

      let(:player) { FactoryGirl.create(:player) }

      it "should increment the player's win count by one" do
        player.add_win!
        player.reload
        expect(player.wins).to eq(1)
      end

      it "should increment the player's draw count by one" do
        player.add_draw!
        player.reload
        expect(player.draws).to eq(1)
      end

      it "should increment the player's loss count by one" do
        player.add_loss!
        player.reload
        expect(player.losses).to eq(1)
      end

    end

  end
end
