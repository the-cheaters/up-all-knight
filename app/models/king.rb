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


  def move_to(destination_x, destination_y)
    valid = super
    if valid
      castle!(destination_x, destination_y) 
    end
    valid
  end

  def can_castle?(destination_x, destination_y)
    return self.moves == 0 && (castling_kingside?(destination_x, destination_y) || 
    castling_queenside?(destination_x, destination_y)) && (game.check?(player)) == false
  end

  def castle!(destination_x, destination_y)
    if castling_kingside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 7, y_position: destination_y, player_id: player_id, type: "Rook").last
      rook.update_attributes(x_position: 5)
    end
    if castling_queenside?(destination_x, destination_y)
      rook = game.pieces.where(x_position: 0, y_position: destination_y, player_id: player_id, type: "Rook").last 
      rook.update_attributes(x_position: 3)
    end
  end

  def castling_kingside?(destination_x, destination_y)
    return (destination_x == 6 && destination_y == y_position) && 
        (is_rook_kingside?(destination_y))
  end

  def castling_queenside?(destination_x, destination_y)
    return (destination_x == 2 && destination_y == y_position) && 
        (is_rook_queenside?(destination_y))
  end

  def is_rook_queenside?(destination_y)
    rook = game.pieces.where(x_position: 0, y_position: destination_y, player_id: player_id, type: "Rook").last
    if rook != nil
      if rook.moves == 0 
        return true
      end
    end
    return false
  end

  def is_rook_kingside?(destination_y)
    rook = game.pieces.where(x_position: 7, y_position: destination_y, player_id: player_id, type: "Rook").last 
    if rook != nil
      if rook.moves == 0 
        return true
      end
    end
    return false
  end


  def unicode_symbol
    if self.get_color == WHITE
      return "&#9812;"
    else
      return "&#9818;"
    end
  end

end
