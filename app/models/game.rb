class Game < ActiveRecord::Base
  
  scope :is_available, -> { where("black_player_id is null or white_player_id = 0") }
  
  
  
  
  has_many :pieces
  has_many :players

  def piece_present?(x, y)
    if self.pieces.where(x_position: x, y_position: y).any?
      return true
    else
      return false
    end
  end

  def get_piece(x, y)
    if self.piece_present?(x, y)
      return self.pieces.where(x_position: x, y_position: y).take
    end
  end
  
end
