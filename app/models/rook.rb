class Rook < Piece
  
  def unicode_symbol
    if self.get_color == WHITE
      return "&#9814;"
    else
      return "&#9820;"
    end
  end
end
