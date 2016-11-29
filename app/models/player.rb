class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook,:twitter, :google]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |player|
      player.provider = auth.provider
      player.uid = auth.uid
      if player.provider == "twitter"
        player.email = "#{auth.info.nickname}@twitter.com"
      else
        player.email = auth.info.email
      end
      player.password = Devise.friendly_token[0,20]
    end
  end

  def join_game(game)
    @enrollment = Enrollment.create
  end

  has_many :games
  has_many :enrollments
end
