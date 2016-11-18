class Game < ActiveRecord::Base
  
  scope :is_available, -> { where(available: true) }
  
  has_many :pieces
  has_many :players
  
end
