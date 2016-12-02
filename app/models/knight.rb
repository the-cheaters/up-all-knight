class Knight < Piece
  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    if valid
      byebug
      if (destination_x - self.x_position).abs != 2 || (destination_y - self.y_position).abs != 1
        byebug
        if (destination_x - self.x_position).abs != 1 || (destination_y - self.y_position).abs != 2
          byebug
          valid = false
        end
      end
    end
    return valid
  end
end
