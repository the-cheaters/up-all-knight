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
      
      it "player count increases by 1" do
        auth = FactoryGirl.create(:auth_hash, :facebook)
        expect { Player.from_omniauth(auth) }.to change{ Player.count }.by(1)
      end
      
      it "should return correct player" do
        auth = FactoryGirl.create(:auth_hash, :facebook)
        Player.from_omniauth(auth)
        expect(Player.last.provider).to eq(auth.provider)
        expect(Player.last.uid).to eq(auth.uid.to_s)
        expect(Player.last.email).to eq(auth.info.email)
      end
    end
  end
end
