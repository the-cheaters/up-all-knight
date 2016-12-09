class Pawn < Piece

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9817;"
    else
      return "&#9823;"
    end
  end

  def valid_move?(destination_x, destination_y)
    valid = super
    if valid
      if pawn_diagonal?(destination_x, destination_y)
        capture_piece(destination_x, destination_y)
        return true
      elsif moving_backward?(destination_y) || (one_square?(destination_x, destination_y) || two_squares?(destination_x, destination_y))
        return false
      end
    end
    return valid
  end

  def on_home_row?
    if (self.get_color == WHITE && y_position == 6) || (self.get_color == BLACK && y_position == 1)
      return true
    else
      return false
    end
  end

  def one_square?(destination_x, destination_y)
    if game.is_piece_present?(destination_x, destination_y)
      return true
    end
    return !on_home_row? && ((destination_x - self.x_position).abs > 0 || (destination_y - self.y_position).abs > 1)
  end

  def two_squares?(destination_x, destination_y)
    if game.is_piece_present?(destination_x, destination_y)
      return true
    end
    return on_home_row? && ((destination_x - self.x_position).abs > 0 || (destination_y - self.y_position).abs > 2)
  end

  def pawn_diagonal?(destination_x, destination_y)
    if game.is_piece_present?(destination_x, destination_y) 
      if (destination_y - self.y_position).abs == 1 && (destination_x - self.x_position).abs == 1
        return true
      end
    else
      return false
    end
  end

  def moving_backward?(destination_y)
    if self.get_color == WHITE 
      if (destination_y - self.y_position) > 0 
        return true
      end
    elsif self.get_color == BLACK 
      if (destination_y - self.y_position) < 0 
        return true
      end 
    end
    false
  end
end
