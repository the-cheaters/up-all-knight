class King < Piece
  
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
    super
    byebug
    castle!(destination_x, destination_y) 
  end

  def can_castle?(destination_x, destination_y)
    byebug
    if self.moves == 0 && castling_kingside?(destination_x, destination_y) || 
    castling_queenside?(destination_x, destination_y) # &&(!self.check?)
      return true
    else
      return false
    end
  end

  def castle!(destination_x, destination_y)
    byebug
    if castling_kingside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 0, y_position: 0, player_id: player_id, type: "Rook").last
      byebug
      rook.update_attributes(x_position: 5)
    end
    if castling_queenside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 0, y_position: 0, player_id: player_id, type: "Rook").first 
      rook.update_attributes(x_position: 3)
    end
  end

  def castling_kingside?(destination_x, destination_y)
    byebug
    if (destination_x == 6 && destination_y == 0) && 
        (is_obstructed?(destination_x, destination_y) == false) && 
        (is_rook_kingside?(destination_y) == true)
      return true
    else
      return false 
    end
  end

  def castling_queenside?(destination_x, destination_y)
    if (destination_x == 2 && destination_y == 0) && 
        (is_obstructed?(destination_x, destination_y) == false) && 
        (is_rook_queenside?(destination_y) == true)
      return true
    else 
      return false
    end
  end

  def is_rook_queenside?(destination_y)
    rook = game.pieces.where(x_position: 0, y_position: y_position, player_id: player_id, type: "Rook").first 
    if rook != nil
      if rook.moves == 0 
        return true
      end
    end
    return false
  end

  def is_rook_kingside?(destination_y)
    rook = game.pieces.where(x_position: 7, y_position: y_position, player_id: player_id, type: "Rook").last 
    byebug
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
