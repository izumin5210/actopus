class RenamePeriodPeriodTime < ActiveRecord::Migration
  def change
    rename_table :periods, :period_times
    rename_column :wday_periods, :period_id, :period_time_id
    rename_column :date_periods, :period_id, :period_time_id
  end
end
