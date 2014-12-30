class AddWdayPeriodIdToSchedulings < ActiveRecord::Migration
  def change
    remove_index :schedulings, [:lecture_id, :period_id, :wday]
    remove_column :schedulings, :period_id
    remove_column :schedulings, :wday
    add_column :schedulings, :wday_period_id, :integer
    change_column :schedulings, :wday_period_id, :integer, null: false
    add_index :schedulings, [:lecture_id, :wday_period_id], unique: true
  end
end
