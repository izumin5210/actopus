class RenameDateOnColunmToTakenOn < ActiveRecord::Migration
  def change
    rename_column :date_periods, :date_on, :taken_on
  end
end
