class Pawn < Piece

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9817;"
    else
      return "&#9823;"
    end
  end
end
