class King < Piece
  
  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    if valid
      if (destination_x - self.x_position).abs > 1 || (destination_y - self.y_position).abs > 1
        valid = false
      end
    end
    return valid
  end


  def unicode_symbol
    if self.get_color == WHITE
      return "&#9812;"
    else
      return "&#9818;"
    end
  end

end
