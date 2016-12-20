require 'rails_helper'

RSpec.describe PusherController, type: :controller do

  let(:white_player) { FactoryGirl.create(:player, id: 100, email: 'blah@blah.com', password: 'SPACECAT') }

  describe "pusher#auth action" do
    it "should not have a 404 response" do
      sign_in white_player
      post :auth
      expect(response).not_to have_http_status(404)
    end
  end

end
