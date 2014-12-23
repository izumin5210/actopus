class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :abbreviation_name, null: false

      t.timestamps null: false
    end
    add_index :courses, :name, unique: true
    add_index :courses, :abbreviation_name, unique: true
  end
end
