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

# CASTLING KING

  def move_to(destination_x, destination_y)
    super
    castle!(destination_x, destination_y) if can_castle?(destination_x, destination_y)
  end

  def can_castle?(destination_x, destination_y)
    if self.moves == 0 && (castling_kingside?(destination_x, destination_y)) || (castling_queenside?(destination_x, destination_y)) # &&(!self.check?)
      return true
    else
      return false
    end
  end

  def castle!(destination_x, destination_y)
    if castling_kingside?(destination_x, destination_y)
      castling_rook_kingside.update_attributes(x_position: 5, y_position: y_position)
    end
    if castling_queenside?(destination_x, destination_y)
      castling_rook_queenside.update_attributes(x_position: 3, y_position: y_position)
    end
    update_attributes(x_position: x_position, y_position: y_position)
  end

  def castling_kingside?(destination_x, destination_y)
    if (destination_x == 6 && destination_y == y_position) && 
        (is_obstructed?(destination_x, destination_y) == false) && 
        (castling_rook_kingside(4, y_position) == false)
      return true
    else
      return false 
    end
  end

  def castling_queenside?(destination_x, destination_y)
    if (destination_x == 2 && destination_y == y_position) && 
        (is_obstructed?(destination_x, destination_y) == false) && 
        (castling_rook_queenside(4, y_position) == false)
      return true
    else 
      return false
    end
  end

  def castling_rook_queenside(destination_x, destination_y)
    @castling_queenside = game.pieces.where(x_position: 0, y_position: y_position, player_id: player_id, type: "Rook").first #&& rook.moves == 0
  end

  def castling_rook_kingside(destination_x, destination_y)
    @castling_kingside = game.pieces.where(x_position: 7, y_position: y_position, player_id: player_id, type: "Rook").first #&& rook.moves == 0
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
