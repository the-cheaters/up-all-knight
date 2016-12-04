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
      if (destination_x - self.x_position).abs < 1 || (destination_y - self.y_position).abs < 1
        valid = false
      end
    end
    return valid

    # pawns can't move backwards
    return false if self.get_color == WHITE && down?(destination_y)
    return false if self.get_color == BLACK && up?(destination_y)

    # conditions for pawn
    one_square?(destination_x, destination_y) ||
    two_sqaures?(destination_x, destination_y) ||
    (pawn_diagonal?(destination_x, destination_y) && capture_piece(x, y))
  end

  def on_home_row?
    return true if (self.get_color == WHITE && y_position == 6) || y_position == 1
  end

  def one_square?(destination_x, destination_y)
    return (destination_x – self.x_position).abs == 0 && (destination_y – self.y_position).abs == 1
  end

  def two_squares?(destination_x, destination_y)
    return on_home_row? && (destination_x - self.x_position).abs == 0 && (destination_y - self.y_position).abs == 2
  end

  def pawn_diagonal?(destination_x, destination_y)
    diagonal?(destination_x, destination_y) && (destination_x – self.x_position) == 1
  end

  def is_obstructed?(destination_x, destination_y)
    return false

  end

end



