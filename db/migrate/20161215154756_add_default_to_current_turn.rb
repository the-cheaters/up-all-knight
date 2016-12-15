class AddDefaultToCurrentTurn < ActiveRecord::Migration
  def change
    change_column :games, :current_turn, :integer, :default => 0
  end
end
