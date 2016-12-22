require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  
  providers = [:facebook, :twitter, :google]
  
  
  providers.each do |provider|
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:player]
    end
    
    describe '#{provider}' do
      
      context 'Success handling' do
        
        before(:each) do
          request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, provider)
          get provider
        end
        
        
        it "should be found" do
          expect(response).to have_http_status(302)
        end
        it "should redirect_to root" do
          expect(response).to redirect_to(root_path)
        end
      end
      
      context 'Failure handling' do
        
        it "should redirect_to new_player_registration_url" do
          get provider
          expect(response).to redirect_to(new_player_registration_path)
        end
        
        it "should redirect_to new_player_registration_url" do
          request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :does_not_persist)
          get provider
          expect(response).to redirect_to(new_player_registration_path)
        end
        
        
      end
      
    end
    
  end
  
  describe 'Failure' do
    after do
      Rails.application.reload_routes!
    end
    
    it 'should redirectto root path' do
      Rails.application.routes.draw do
        devise_scope :Player do
          get '/player/auth/failure' => 'omniauth_callbacks#failure'
        end
        root 'games#index'
      end
      request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :twitter)
      get :failure
      expect(response).to redirect_to root_path
    end
  end
end
