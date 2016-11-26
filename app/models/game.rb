class Game < ActiveRecord::Base

  scope :is_available, -> { where("black_player_id is null or white_player_id = 0") }




  has_many :pieces
  has_many :players
  has_one :enrollment

end
