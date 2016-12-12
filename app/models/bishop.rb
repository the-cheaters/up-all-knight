class Bishop < Piece

  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    valid && diagonal(destination_x, destination_y)

  end

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9815;"
    else
      return "&#9821;"
    end
  end
end
