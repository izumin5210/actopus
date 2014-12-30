class RenameTeachingLecturesLecturing < ActiveRecord::Migration
  def change
    rename_table :teaching_lectures, :lecturings
  end
end
