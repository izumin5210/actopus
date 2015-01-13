class AddSpecialTargetToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :special_target, :string
  end
end
