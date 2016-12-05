class Pawn < Piece

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9817;"
    else
      return "&#9823;"
    end
  end

  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    if valid 
      if pawn_diagonal?(destination_x, destination_y)
        capture_piece(destination_x, destination_y)
        return true
      elsif move_backward?(destination_y) && (one_square?(destination_x, destination_y) || two_squares?(destination_x, destination_y))
        return false
      end
      move_backward?(destination_y) 
    end
    return valid
  end

  def on_home_row?
    return true if (self.get_color == WHITE && y_position == 1) || y_position == 6
  end

  def one_square?(destination_x, destination_y)
    return !on_home_row? && ((destination_x – self.x_position).abs > 0 || (destination_y – self.y_position).abs > 1)
  end

  def two_squares?(destination_x, destination_y)
    return on_home_row? && ((destination_x - self.x_position).abs > 0 || (destination_y - self.y_position).abs > 2)
  end

  def pawn_diagonal?(destination_x, destination_y)
    if game.is_piece_present?(destination_x, destination_y) 
      return (destination_y - self.y_position).abs == 1 && (destination_x – self.x_position).abs == 1
    else
      return false
    end
  end

  def move_backward?(destination_y)
    return self.get_color == WHITE && (destination_y - self.y_position) > 0
    return self.get_color == BLACK && (destination_y - self.y_position) < 0
  end

  # def move_horizontal?(destination_x)
  #   byebug
  #   (x_position - destination_x).abs != 0
  # end

  # def promotion?(destination_y)
  #   byebug
  #   destination_y == 7 && self.get_color == WHITE || destination_y == 0 && self.get_color == BLACK
  # end

end
