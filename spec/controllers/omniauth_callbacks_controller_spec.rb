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
      
      
      it "should be found" do
        expect(response).to have_http_status(302)
      end
      it "should redirect_to root" do
        expect(response).to redirect_to(root_path)
      end
    end
    
    context 'Failure handling' do
      
      it "should redirect_to new_player_registration_url" do
        get :facebook
        expect(response).to redirect_to(new_player_registration_path)
      end
      
      it "should redirect_to new_player_registration_url" do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :does_not_persist)
        get :facebook
        expect(response).to redirect_to(new_player_registration_path)
      end
      
      
    end
    
  end
  
  describe 'Twitter' do
    
    context 'Success handling' do
      
      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :twitter)
        get :twitter
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
        get :twitter
        expect(response).to redirect_to(new_player_registration_path)
      end
      
      it "should redirect_to new_player_registration_url" do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :does_not_persist)
        get :twitter
        expect(response).to redirect_to(new_player_registration_path)
      end
      
      
    end
    
    
  end
  
  describe 'Google' do
    
    context 'Success handling' do
      
      before(:each) do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :google)
        get :google
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
        get :google
        expect(response).to redirect_to(new_player_registration_path)
      end
      
      it "should redirect_to new_player_registration_url" do
        request.env['omniauth.auth'] = FactoryGirl.create(:auth_hash, :does_not_persist)
        get :google
        expect(response).to redirect_to(new_player_registration_path)
      end
      
    end
    
  end
  
  describe 'Failure' do
    
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
