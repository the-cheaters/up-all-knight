class AddColumnsToTimers < ActiveRecord::Migration
  def change
    add_column :timers, :time_left, :integer
    add_column :timers, :start_time, :datetime
    add_column :timers, :running, :boolean
  end
end
