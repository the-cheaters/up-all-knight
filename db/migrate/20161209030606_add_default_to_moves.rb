class AddDefaultToMoves < ActiveRecord::Migration
  def change
    change_column :pieces, :moves, :integer, :default => 0
  end
end
