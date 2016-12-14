class King < Piece

  def y_position
    y_position = 0
    if self.get_color == WHITE
      y_position = 7
    end
    y_position
  end  
  
  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    if valid
      if can_castle?(destination_x, destination_y)
        return true
      elsif (destination_x - self.x_position).abs > 1 || (destination_y - self.y_position).abs > 1
        valid = false
      end
    end
    return valid
  end

  

# CASTLING KING

  def move_to(destination_x, destination_y)
    valid = super
    if valid
      castle!(destination_x, destination_y) 
    end
    valid
  end

  def can_castle?(destination_x, destination_y)
    if self.moves == 0 && (castling_kingside?(destination_x, destination_y) || 
    castling_queenside?(destination_x, destination_y)) # &&(!self.check?)
      return true
    else
      return false
    end
  end

  def castle!(destination_x, destination_y)
    if castling_kingside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 7, y_position: y_position, player_id: player_id, type: "Rook").last
      rook.update_attributes(x_position: 5)
    end
    if castling_queenside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 0, y_position: y_position, player_id: player_id, type: "Rook").last 
      rook.update_attributes(x_position: 3)
    end
  end

  def castling_kingside?(destination_x, destination_y)
    if (destination_x == 6 && destination_y == y_position) && 
        (is_rook_kingside? == true)
      return true
    else
      return false 
    end
  end

  def castling_queenside?(destination_x, destination_y)
    if (destination_x == 2 && destination_y == y_position) && 
        (is_rook_queenside? == true)
      return true
    else 
      return false
    end
  end

  def is_rook_queenside?
    rook = game.pieces.where(x_position: 0, y_position: y_position, player_id: player_id, type: "Rook").last
    if rook != nil
      if rook.moves == 0 
        return true
      end
    end
    return false
  end

  def is_rook_kingside?
    rook = game.pieces.where(x_position: 7, y_position: y_position, player_id: player_id, type: "Rook").last 
    if rook != nil
      if rook.moves == 0 
        return true
      end
    end
    return false
  end

  # END ----- CASTLING KING ------ END



  def unicode_symbol
    if self.get_color == WHITE
      return "&#9812;"
    else
      return "&#9818;"
    end
  end

end
