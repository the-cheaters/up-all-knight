class Bishop < Piece

  def unicode_symbol
    if self.get_color == WHITE
      return "&#9815;"
    else
      return "&#9821;"
    end
  end
end
