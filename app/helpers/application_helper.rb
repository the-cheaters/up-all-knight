module ApplicationHelper
  
  def square_color(row, column)
    if ((row + column) % 2 == 0)
      return "white"
    else
      return "black"
    end
  end

  def get_player
    if current_player.id == @game.white_player_id
      return "white"
    else
      return "black"
    end 
  end

end