class AddBlitzButtonsToGame < ActiveRecord::Migration
  def change
    add_column :games, :white_ready, :boolean, :default => false
    add_column :games, :black_ready, :boolean, :default => false
  end
end
