class Queen < Piece
  
  def unicode_symbol
    if self.get_color == WHITE
      return "&#9813;"
    else
      return "&#9819;"
    end
  end
end
