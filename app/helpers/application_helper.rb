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

def get_player
  if current_player.id == @game.white_player_id
    return "white"
  else
    return "black"
  end 
end
