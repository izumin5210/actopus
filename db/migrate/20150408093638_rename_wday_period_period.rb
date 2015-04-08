class RenameWdayPeriodPeriod < ActiveRecord::Migration
  def change
    rename_table :wday_periods, :periods
    rename_column :schedulings, :wday_period_id, :period_id
  end
end
