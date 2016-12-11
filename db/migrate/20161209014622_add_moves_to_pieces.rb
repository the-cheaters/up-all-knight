class AddMovesToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :moves, :integer
  end
end
