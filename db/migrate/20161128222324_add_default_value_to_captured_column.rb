class AddDefaultValueToCapturedColumn < ActiveRecord::Migration
  def change
    change_column :pieces, :captured, :boolean, :default => false
  end
end
