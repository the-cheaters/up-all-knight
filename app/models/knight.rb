class Knight < Piece

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9816;"
    else
      return "&#9822;"
    end
  end
end
