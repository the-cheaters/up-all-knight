class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook,:twitter, :google]
 
  has_many :timers
   
  def self.from_omniauth(auth)
    
    where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |player|
      player.provider = auth.provider
      player.uid = auth.uid.to_s
      if player.provider == "twitter"
        player.email = "#{auth.info.nickname}@twitter.com"
      else
        player.email = auth.info.email
      end
      player.password = Devise.friendly_token[0,20]
    end
  end
end
