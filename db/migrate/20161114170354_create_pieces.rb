class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :type

      t.integer :player_id
      t.integer :game_id
      t.integer :x_position
      t.integer :y_position

      t.boolean :captured

      t.timestamps
    end
  end
end
