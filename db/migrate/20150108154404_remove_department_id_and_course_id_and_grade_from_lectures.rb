class RemoveDepartmentIdAndCourseIdAndGradeFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :department_id
    remove_column :lectures, :course_id
    remove_column :lectures, :grade
    add_index :lectures, :term_id
  end
end
