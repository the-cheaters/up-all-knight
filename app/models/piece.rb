class Piece < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player

  def is_obstructed?(destination_x, destination_y)
    location_x = self.x_position
    location_y = self.y_position
    if location_x == destination_x
      # check for vertical obstruction
      incrementer = -1 if location_y > destination_y else 1
      position_y = location_y + incrementer
      while position_y != destination_y
        if game.pieces.where(x_position: location_x, y_position: position_y).any?
          return true
        end
        position_y += incrementer
      end
      return false
    elsif location_y == destination_y
      # check for horizontal obstruction
    elsif (location_x - destination_x).abs == (location_y - destination_y).abs
      # check for diagonal obstruction
    end
  end
  
end
