require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  describe "sign out" do

      it "should sign out a player" do
        player = FactoryGirl.create(:player)
        sign_in player
        sign_out player
        expect(response).to have_http_status(:success)
      end

  end

end
