 module ApplicationHelper

  def square_color(row, column)
    if (row % 2 == 0) 
      if (column % 2 == 0) 
      return "white"
      else
      "black"
      end
    else
      if (column % 2 == 1)
        return "white"
      else
        "black"
      end
    end
  end
 end
