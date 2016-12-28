class AddCapturedAtToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :captured_at, :datetime
  end
end