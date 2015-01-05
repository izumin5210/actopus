class CreateDatePeriods < ActiveRecord::Migration
  def change
    create_table :date_periods do |t|
      t.integer :period_id
      t.date :date_on

      t.timestamps null: false
    end
  end
end
