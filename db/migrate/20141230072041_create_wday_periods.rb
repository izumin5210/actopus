class CreateWdayPeriods < ActiveRecord::Migration
  def change
    create_table :wday_periods do |t|
      t.integer :period_id, null: false
      t.integer :wday, null: false

      t.timestamps null: false
    end
    add_index :wday_periods, :period_id
    add_index :wday_periods, :wday
    add_index :wday_periods, [:period_id, :wday], unique: true
  end
end
