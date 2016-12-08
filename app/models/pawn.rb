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
      elsif moving_backward?(destination_y) && (one_square?(destination_x, destination_y) || two_squares?(destination_x, destination_y))
        return false
      end
      moving_backward?(destination_y)
    end
    return valid
  end

  def on_home_row?
    return true if (self.get_color == WHITE && y_position == 1) || self.get_color == BLACK && y_position == 6
  end

  def one_square?(destination_x, destination_y)
    return !on_home_row? && ((destination_x – self.x_position).abs > 0 || (destination_y – self.y_position).abs > 1)
  end

  def two_squares?(destination_x, destination_y)
    return on_home_row? && ((destination_x - self.x_position).abs > 0 || (destination_y - self.y_position).abs > 2)
  end

  def pawn_diagonal?(destination_x, destination_y)
    if game.is_piece_present?(destination_x, destination_y) 
      return (destination_y - self.y_position).abs == 1 && (destination_x - self.x_position).abs == 1
    else
      return false
    end
  end

  def moving_backward?(destination_y)
    return (destination_y - self.y_position) > 0 if self.get_color == WHITE 
    return (destination_y - self.y_position) < 0 if self.get_color == BLACK 
  end
end
