class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name, null: false
      t.string :xml_filename, null: false
      t.date :begin_at, null: false
      t.date :end_at, null: false

      t.timestamps null: false
    end
    add_index :terms, :xml_filename, unique: true
    add_index :terms, [:begin_at, :end_at], unique: true
  end
end
