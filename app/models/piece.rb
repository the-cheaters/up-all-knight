class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  WHITE = "white"
  BLACK = "black"
  
  def capture!
    self.update_attributes(:captured => true, :captured_at => Time.now, :x_position => nil, :y_position => nil)
  end
  
  def capture_piece(x, y)
    piece_to_capture = game.get_piece(x, y)
    if !piece_to_capture.nil? && piece_to_capture.get_color != self.get_color
      piece_to_capture.capture!
    else
      fail "There is no piece of the opposite color to capture."
    end
  end
  
  def valid_move?(destination_x, destination_y)
    valid = true
    # Check if piece is obstructed
    if self.is_obstructed?(destination_x, destination_y)
      valid = false
      # Check if destination is occupied by a piece of the same color
    elsif game.is_piece_present?(destination_x, destination_y)
      other_piece = game.get_piece(destination_x, destination_y)
      if self.get_color == other_piece.get_color
        valid = false
      end
    end
    return valid
  end
  
  def get_color
    if self.player_id == game.white_player_id
      return WHITE
    elsif self.player_id == game.black_player_id
      return BLACK
    end
  end
  
  
  def is_obstructed?(destination_x, destination_y)
    location_x = self.x_position
    location_y = self.y_position
    if location_x == destination_x
      # check for vertical obstruction
      location_y > destination_y ? incrementer = -1 : incrementer = 1
      position_y = location_y + incrementer
      min, max = [position_y, destination_y].minmax
      range = range(min, max, incrementer)
      if game.pieces.where(x_position: location_x, y_position: range).any?
        return true
      end
      return false
    elsif location_y == destination_y
      # check for horizontal obstruction
      location_x > destination_x ? incrementer = -1 : incrementer = 1
      position_x = location_x + incrementer
      min, max = [position_x, destination_x].minmax
      range = range(min, max, incrementer)
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
      min_x, max_x = [position_x, destination_x].minmax
      range_x = range(min_x, max_x, x_incrementer, true)
      min_y, max_y = [position_y, destination_y].minmax
      range_y = range(min_y, max_y, y_incrementer, true)
      if game.pieces.where(x_position: range_x, y_position: range_y).any?
        return true
      end
      return false
    end
  end

  def range(min, max, incrementer, diagonal=false)
    range = nil
    if min != max
      if incrementer > 0 && diagonal
        max = max - incrementer
      elsif incrementer < 0
        min = min - incrementer
      end
      min == max ? range = min : range = min...max
    end
    return range
  end
  
end
