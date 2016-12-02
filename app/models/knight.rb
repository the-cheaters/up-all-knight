class Knight < Piece
<<<<<<< HEAD

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9816;"
    else
      return "&#9822;"
    end
=======
  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    if valid
      if (destination_x - self.x_position).abs != 2 || (destination_y - self.y_position).abs != 1
        if (destination_x - self.x_position).abs != 1 || (destination_y - self.y_position).abs != 2
          valid = false
        end
      end
    end
    return valid
  end
  
  def  is_obstructed?(destination_x, destination_y)
    return false
>>>>>>> 8eb4ce026b010840246662ef6f9317fbb50dd2f0
  end
end
