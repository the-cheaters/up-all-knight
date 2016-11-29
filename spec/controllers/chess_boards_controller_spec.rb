require 'rails_helper'

RSpec.describe ChessBoardsController, type: :controller do


  describe "show" do
    it "renders the show template with chessboard" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end
  end
end
