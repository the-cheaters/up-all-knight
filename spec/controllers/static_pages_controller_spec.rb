require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "static_pages#ranking" do
    it "should successfully load the page" do
      get :ranking
      expect(response).to have_http_status(:success)
    end
  end

end
