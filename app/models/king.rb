class King < Piece

  def valid_move?(destination_x, destination_y)
    super
    if (destination_x - self.x_position).abs > 1 || (destination_y - self.y_position).abs > 1
      return false
    else
      return true
    end
  end

end
