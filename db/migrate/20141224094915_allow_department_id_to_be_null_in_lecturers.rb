class AllowDepartmentIdToBeNullInLecturers < ActiveRecord::Migration
  def change
    change_column :lecturers, :department_id, :integer, null: true
  end
end
