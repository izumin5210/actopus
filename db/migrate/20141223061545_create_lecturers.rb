class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name, null: false
      t.integer :department_id, null: false

      t.timestamps null: false
    end
  end
end
