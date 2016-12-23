class Rook < Piece
  
  def valid_move?(destination_x, destination_y)
    valid = super(destination_x, destination_y)
    valid && (
    horizontal(destination_y) ||
    vertical(destination_x)
    )
  end
  
  def unicode_symbol
    byebug
    if self.get_color == WHITE
      return "&#9814;"
    else
      return "&#9820;"
    end
  end
end
