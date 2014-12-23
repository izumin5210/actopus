class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.string :abbreviation_name, null: false

      t.timestamps null: false
    end
    add_index :departments, :name, unique: true
    add_index :departments, :abbreviation_name, unique: true
  end
end
