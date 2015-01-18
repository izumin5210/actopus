class ChangeReschedulingsCategoryToInteger < ActiveRecord::Migration
  def change
    remove_column :reschedulings, :category
    add_column :reschedulings, :category, :integer
  end
end
