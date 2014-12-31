class RenameHeldLecturesSchedulings < ActiveRecord::Migration
  def change
    rename_table :held_lectures, :schedulings
  end
end
