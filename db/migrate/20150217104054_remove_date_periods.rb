class RemoveDatePeriods < ActiveRecord::Migration
  def change
    drop_table :date_periods
  end
end
