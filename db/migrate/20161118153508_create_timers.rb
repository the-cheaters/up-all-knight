class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.time :time

      t.integer :player_id
      t.integer :game_id

      t.timestamps
    end
  end
end
