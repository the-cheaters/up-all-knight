class AddLastMovedPieceIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :last_moved_piece_id, :integer
  end
end
