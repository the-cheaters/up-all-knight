class Piece < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player

  def is_obstructed?(destination_x, destination_y)
    location_x = self.x_position
    location_y = self.y_position
    if location_x == destination_x
      # check for vertical obstruction
      location_y > destination_y ? incrementer = -1 : incrementer = 1
      position_y = location_y + incrementer
      range = [position_y, destination_y].min...[position_y, destination_y].max
      if game.pieces.where(x_position: location_x, y_position: range).any?
        return true
      end
      return false
    elsif location_y == destination_y
      # check for horizontal obstruction
      location_x > destination_x ? incrementer = -1 : incrementer = 1
      position_x = location_x + incrementer
      range = [position_x, destination_x].min...[position_x, destination_x].max
      if game.pieces.where(x_position: range, y_position: location_y).any?
        return true
      end
      return false
    elsif (location_x - destination_x).abs == (location_y - destination_y).abs
      # check for diagonal obstruction
      location_x > destination_x ? x_incrementer = -1 : x_incrementer = 1
      location_y > destination_y ? y_incrementer = -1 : y_incrementer = 1
      position_x = location_x + x_incrementer
      position_y = location_y + y_incrementer
      range_x = [position_x, destination_x].min...[position_x, destination_x].max
      range_y = [position_y, destination_y].min...[position_y, destination_y].max
      if game.pieces.where(x_position: range_x, y_position: range_y).any?
        return true
      end
      return false
    end
  end
  
end
