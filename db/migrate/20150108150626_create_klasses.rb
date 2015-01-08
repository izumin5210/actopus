class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name, null: false
      t.integer :department_id, null: false
      t.integer :course_id
      t.integer :grade, null: false
      t.string :name, null: false
      t.string :category, null: false

      t.timestamps null: false
    end
    add_index :klasses, :name, unique: true
    add_index :klasses, :department_id
    add_index :klasses, :course_id
    add_index :klasses, :grade
    add_index :klasses, [:department_id, :course_id, :grade], unique: true
  end
end
