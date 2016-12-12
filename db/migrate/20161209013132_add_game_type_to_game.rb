class AddGameTypeToGame < ActiveRecord::Migration
  def change
    add_column :games, :is_blitz, :boolean, :default => false
  end
end
