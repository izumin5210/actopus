class CreateTeachingLectures < ActiveRecord::Migration
  def change
    create_table :teaching_lectures do |t|
      t.integer :lecture_id, null: false
      t.integer :lecturer_id, null: false

      t.timestamps null: false
    end
    add_index :teaching_lectures, [:lecture_id, :lecturer_id], unique: true
  end
end
