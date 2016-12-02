class Queen < Piece

  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    horizontal = (destination_y == self.y_position)
    vertical = (destination_x == self.x_position)
    diagonal = (
      (destination_x - self.x_position).abs == 
      (destination_y - self.y_position).abs
    )
    valid && (horizontal || vertical || diagonal)
  end

end
