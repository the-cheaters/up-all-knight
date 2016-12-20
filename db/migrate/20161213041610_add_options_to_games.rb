class AddOptionsToGames < ActiveRecord::Migration
  def change
    add_column :games, :white_draw, :boolean
    add_column :games, :black_draw, :boolean
    add_column :games, :white_forfeit, :boolean
    add_column :games, :black_forfeit, :boolean
  end
end
