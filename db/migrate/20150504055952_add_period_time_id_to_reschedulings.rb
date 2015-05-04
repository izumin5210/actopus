class AddPeriodTimeIdToReschedulings < ActiveRecord::Migration
  def change
    add_column :reschedulings, :period_time_id, :integer
    add_index :reschedulings, :period_time_id
  end
end
