class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name, null: false
      t.integer :grade, null: false
      t.boolean :overseas_student, default: false
      t.integer :department_id, null: false
      t.integer :course_id
      t.integer :term_id, null: false

      t.timestamps null: false
    end
  end
end
