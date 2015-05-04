class AddScheduledOnToRescheduling < ActiveRecord::Migration
  def change
    add_column :reschedulings, :scheduled_on, :date
    add_index :reschedulings, :scheduled_on
  end
end
