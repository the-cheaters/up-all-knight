class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :move_result

      t.integer :black_player_id
      t.integer :white_player_id
      t.integer :current_turn
      t.integer :winning_player_id

      t.timestamps
    end
  end
end
