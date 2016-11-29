class Enrollment < ActiveRecord::Base
  belongs_to :game
  belongs_to :white_player_id, class_name: "Player"
  belongs_to :black_player_id, class_name: "Player"

end
