class ChangeAndRemoveColumnsOfLectures < ActiveRecord::Migration
  def change
    change_column :lectures, :special_target, :integer
    remove_column :lectures, :overseas_student
  end
end
