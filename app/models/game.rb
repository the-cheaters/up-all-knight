class Game < ActiveRecord::Base
  
  scope :is_available, -> { where("black_player_id is null or white_player_id = 0") }
  
  
  
  
  has_many :pieces
  has_many :players

  def is_piece_present?(x, y)
    self.pieces.where(x_position: x, y_position: y).any?
  end

  def get_piece(x, y)
    self.pieces.where(x_position: x, y_position: y).take
  end
  
end
