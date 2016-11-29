class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :hash_check
  
  def twitter
    
    @player = Player.from_omniauth(request.env["omniauth.auth"])
    
    if @player.persisted?
      
      sign_in_and_redirect @player, :event => :authentication
      set_flash_message(:notice, :success, :kind => "twitter") if is_navigational_format?
      
    else
      redirect_to new_player_registration_url
    end
  end
  
  def failure
    redirect_to root_path
  end
  
  def google
    
    @player = Player.from_omniauth(request.env["omniauth.auth"])
    
    if @player.persisted?
      sign_in_and_redirect @player, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      redirect_to new_player_registration_url
    end
  end
  
  def facebook
    
    @player = Player.from_omniauth(request.env["omniauth.auth"])
    
    if @player.persisted?
      sign_in_and_redirect @player, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      redirect_to new_player_registration_url
    end
  end
  
  private
  
  def hash_check
    if request.env["omniauth.auth"].nil?
      redirect_to new_player_registration_url
    end
  end
  
end
