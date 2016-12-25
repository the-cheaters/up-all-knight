class AddGameStartedToGames < ActiveRecord::Migration
  def change
    add_column :games, :has_started, :boolean, :default => false
  end
end
