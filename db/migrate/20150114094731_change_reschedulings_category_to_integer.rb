class ChangeReschedulingsCategoryToInteger < ActiveRecord::Migration
  def change
    change_column :reschedulings, :category, :integer
  end
end
