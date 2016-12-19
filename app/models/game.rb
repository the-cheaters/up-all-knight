class Game < ActiveRecord::Base

  scope :is_available, -> { where("black_player_id is null or white_player_id = 0") }

  after_create :populate_board!

  def populate_board!
    # black_player_id
    (0..7).each do |i|
      Pawn.create(player_id: self.black_player_id, game_id: self.id, x_position: i, y_position: 1)
    end

    Rook.create(player_id: self.black_player_id, game_id: self.id, x_position: 0, y_position: 0)
    Rook.create(player_id: self.black_player_id, game_id: self.id, x_position: 7, y_position: 0)
    Knight.create(player_id: self.black_player_id, game_id: self.id, x_position: 1, y_position: 0)
    Knight.create(player_id: self.black_player_id, game_id: self.id, x_position: 6, y_position: 0)
    Bishop.create(player_id: self.black_player_id, game_id: self.id, x_position: 2, y_position: 0)
    Bishop.create(player_id: self.black_player_id, game_id: self.id, x_position: 5, y_position: 0)
    Queen.create(player_id: self.black_player_id, game_id: self.id, x_position: 3, y_position: 0)
    King.create(player_id: self.black_player_id, game_id: self.id, x_position: 4, y_position: 0)



    # white_player_id
    (0..7).each do |i|
      Pawn.create(player_id: self.white_player_id, game_id: self.id, x_position: i, y_position: 6)
    end

    Rook.create(player_id: self.white_player_id, game_id: self.id, x_position: 0, y_position: 7)
    Rook.create(player_id: self.white_player_id, game_id: self.id, x_position: 7, y_position: 7)
    Knight.create(player_id: self.white_player_id, game_id: self.id, x_position: 1, y_position: 7)
    Knight.create(player_id: self.white_player_id, game_id: self.id, x_position: 6, y_position: 7)
    Bishop.create(player_id: self.white_player_id, game_id: self.id, x_position: 2, y_position: 7)
    Bishop.create(player_id: self.white_player_id, game_id: self.id, x_position: 5, y_position: 7)
    Queen.create(player_id: self.white_player_id, game_id: self.id, x_position: 3, y_position: 7)
    King.create(player_id: self.white_player_id, game_id: self.id, x_position: 4, y_position: 7)
  end



  has_many :pieces
  has_many :players

  def is_piece_present?(x, y)
    self.pieces.where(x_position: x, y_position: y).any?
  end

  def get_piece(x, y)
    self.pieces.where(x_position: x, y_position: y).take
  end

  def check?(player)
    king = pieces.find_by(type: 'King', player_id: player)
    opponents = pieces.find_by(player_id: self.white_player_id)

    opponents.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        true
      else
        false
      end
    end
  end

end
