require 'rails_helper'

RSpec.describe ChessBoardsController, type: :controller do
  render_views

  describe "index" do
    it "renders the index template with chessboard" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
