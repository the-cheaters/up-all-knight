class Game < ActiveRecord::Base

  scope :is_available, -> { where("black_player_id is null or white_player_id = 0") }

  after_create :populate_board!

 def populate_board!
   # black_player_id
   0..7 do |i|
     Pawn.create(player_id: self.black_player_id, game_id: self.id, x_position: i, y_position: 1, captured: false)
   end

   Rook.create(player_id: self.black_player_id, game_id: self.id, x_position: 0, y_position: 0, captured: false)
   Rook.create(player_id: self.black_player_id, game_id: self.id, x_position: 7, y_position: 0, captured: false)
   Horse.create(player_id: self.black_player_id, game_id: self.id, x_position: 1, y_position: 0, captured: false)
   Horse.create(player_id: self.black_player_id, game_id: self.id, x_position: 6, y_position: 0, captured: false)
   Bishop.create(player_id: self.black_player_id, game_id: self.id, x_position: 2, y_position: 0, captured: false)
   Bishop.create(player_id: self.black_player_id, game_id: self.id, x_position: 5, y_position: 0, captured: false)
   Queen.create(player_id: self.black_player_id, game_id: self.id, x_position: 3, y_position: 0, captured: false)
   King.create(player_id: self.black_player_id, game_id: self.id, x_position: 4, y_position: 0, captured: false)



   # white_player_id
   0..7 do |i|
     Pawn.create(player_id: self.white_player_id, game_id: self.id, x_position: i, y_position: 6, captured: false)
   end

   Rook.create(player_id: self.white_player_id, game_id: self.id, x_position: 0, y_position: 7, captured: false)
   Rook.create(player_id: self.white_player_id, game_id: self.id, x_position: 7, y_position: 7, captured: false)
   Horse.create(player_id: self.white_player_id, game_id: self.id, x_position: 1, y_position: 7, captured: false)
   Horse.create(player_id: self.white_player_id, game_id: self.id, x_position: 6, y_position: 7, captured: false)
   Bishop.create(player_id: self.white_player_id, game_id: self.id, x_position: 2, y_position: 7, captured: false)
   Bishop.create(player_id: self.white_player_id, game_id: self.id, x_position: 5, y_position: 7, captured: false)
   Queen.create(player_id: self.white_player_id, game_id: self.id, x_position: 3, y_position: 7, captured: false)
   King.create(player_id: self.white_player_id, game_id: self.id, x_position: 4, y_position: 7, captured: false)
 end



  has_many :pieces
  has_many :players

end
