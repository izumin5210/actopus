class RemoveDatePeriodIdsFromReschedulings < ActiveRecord::Migration
  def change
    remove_column :reschedulings, :before_date_period_id
    remove_column :reschedulings, :after_date_period_id
  end
end
