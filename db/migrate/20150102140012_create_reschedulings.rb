class CreateReschedulings < ActiveRecord::Migration
  def change
    create_table :reschedulings do |t|
      t.integer :lecture_id
      t.integer :before_date_period_id
      t.integer :after_date_period_id
      t.string :category

      t.timestamps null: false
    end
  end
end
