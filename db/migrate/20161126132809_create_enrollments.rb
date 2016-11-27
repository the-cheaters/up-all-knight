class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :game_id
      t.integer :white_player_id
      t.integer :black_player_id

      t.timestamps
    end
  end
end
