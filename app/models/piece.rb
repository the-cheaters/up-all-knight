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
  
  def move_to(destination_x, destination_y)
    valid = self.valid_move?(destination_x, destination_y)
    if game.check?(player_id) && self.type != "King"
      valid = false
    end
    if valid
      if self.moves < 2
        moves_updated = self.moves + 1
        self.update_attributes(:x_position => destination_x, :y_position => destination_y, :moves => moves_updated)
      else
        self.update_attributes(:x_position => destination_x, :y_position => destination_y)
      end
      if self.game.is_piece_present?(destination_x, destination_y) &&
        self.game.get_piece(destination_x, destination_y).get_color != self.get_color
        self.capture_piece(destination_x, destination_y)
      else
        self.en_passant(destination_x, destination_y)
      end
      self.game.change_turns!
      self.game.update(:last_moved_piece_id => self.id)
    end
    valid
  end
  
  def en_passant(destination_x, destination_y)
    if destination_y == 2 || destination_y == 5
      destination_y == 2 ? incrementer = 1 : incrementer = -1
      incremented_y = destination_y + incrementer
      if self.game.is_piece_present?(destination_x, incremented_y)
        other_piece = game.get_piece(destination_x, incremented_y)
        if other_piece.type == 'Pawn' &&
          other_piece.moves == 1 &&
          other_piece.get_color != self.get_color &&
          other_piece.id == self.game.last_moved_piece_id
          self.capture_piece(destination_x, incremented_y)
        end
      end
    end
  end
  
  def can_pawn_promote?(destination_y)
    if self.type == "Pawn"
      if self.get_color == "white"
        if destination_y == 0
          return true
        end
      elsif self.get_color == "black"
        if destination_y == 7
          return true
        end
      end
      return false
    end
  end
  
  def promote_pawn(new_piece)
    if self.type == "Pawn"
      self.type = new_piece
      save
    end
  end
  
  def valid_move?(destination_x, destination_y)
    valid = true
    
    if destination_x == nil || destination_y == nil
      
      valid = false
    end
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
    location_x = self.x_position.to_i
    location_y = self.y_position.to_i
    if vertical(destination_x)
      # check for vertical obstruction
      location_y > destination_y ? incrementer = -1 : incrementer = 1
      position_y = location_y + incrementer
      min, max = [position_y, destination_y].minmax
      range = range(min, max, incrementer)
      if game.pieces.where(x_position: location_x, y_position: range).any?
        return true
      end
      return false
    elsif horizontal(destination_y)
      # check for horizontal obstruction
      location_x > destination_x ? incrementer = -1 : incrementer = 1
      position_x = location_x + incrementer
      min, max = [position_x, destination_x].minmax
      range = range(min, max, incrementer)
      if game.pieces.where(x_position: range, y_position: location_y).any?
        return true
      end
      return false
    elsif diagonal(destination_x, destination_y)
      # check for diagonal obstruction
      location_x > destination_x.to_i ? x_incrementer = -1 : x_incrementer = 1
      location_y > destination_y.to_i ? y_incrementer = -1 : y_incrementer = 1
      position_x = location_x + x_incrementer
      position_y = location_y + y_incrementer
      min_x, max_x = [position_x, destination_x].minmax
      range_x = range(min_x, max_x, x_incrementer, true)
      min_y, max_y = [position_y, destination_y].minmax
      range_y = range(min_y, max_y, y_incrementer, true)
      if range_x && range_y != nil
        if game.pieces.where(x_position: range_x, y_position: range_y).any?
          return true
        end
      end
      return false
    end
  end
  
  private
  
  def range(min, max, incrementer, diagonal=false)
    range = nil
    if min != max
      if incrementer > 0 && diagonal
        max = max - incrementer
      elsif incrementer < 0
        min = min - incrementer
      end
      if diagonal
        min == max ? range = min : range = max...min
      else
        min == max ? range = min : range = min...max
      end
    end
    return range
  end
  
  def horizontal(destination_y)
    destination_y == self.y_position
  end
  
  def vertical(destination_x)
    destination_x == self.x_position
  end
  
  def diagonal(destination_x, destination_y)
    (destination_x.to_i - self.x_position.to_i).abs ==
    (destination_y.to_i - self.y_position.to_i).abs
  end
  
end
