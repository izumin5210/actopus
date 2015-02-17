class ChangeReschedulingsColumns < ActiveRecord::Migration
  def change
    remove_column :reschedulings, :before_date_period_id
    remove_column :reschedulings, :after_date_period_id

    add_column :reschedulings, :period_id, :integer
    add_column :reschedulings, :taken_on, :date

    add_index :reschedulings, :lecture_id
    add_index :reschedulings, :period_id
    add_index :reschedulings, :taken_on
    add_index :reschedulings, :category
  end
end
