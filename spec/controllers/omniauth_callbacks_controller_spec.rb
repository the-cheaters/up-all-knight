require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:player]
  end
  
  describe 'Facebook' do
    
    context 'Success handling' do
      
      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :facebook)
        get :facebook
      end
      
      let(:player) { Player.find_by(email: 'testuser@facebook.com') }
      
    end
    
    
  end
  
  describe 'Twitter' do
    
    context 'Success handling' do
      
      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :twitter)
        get :facebook
      end
      
      let(:player) { Player.find_by(email: 'testuser@twitter.com') }
      
    end
    
    
  end
  
  describe 'Google' do
    
    context 'Success handling' do
      
      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :google)
        get :facebook
      end
      
      let(:player) { Player.find_by(email: 'testuser@gmail.com') }
      
    end
    
  end
  
  describe 'Failure' do
    
    after(:each) do
      Rails.application.reload_routes!
    end
    
    before(:each) do
      
      Rails.application.routes.draw do
        devise_scope :Player do
          get '/player/auth/failure' => 'omniauth_callbacks#failure'
        end
        root 'static_pages#index'
      end
      
      get :failure
      
    end
    
    it 'should redirectto root path' do
      expect(response).to redirect_to root_path
    end
    
    
    
  end
  
end
