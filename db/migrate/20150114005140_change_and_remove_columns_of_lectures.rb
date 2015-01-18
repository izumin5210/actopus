class ChangeAndRemoveColumnsOfLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :special_target
    add_column :lectures, :special_target, :integer
    remove_column :lectures, :overseas_student
  end
end
