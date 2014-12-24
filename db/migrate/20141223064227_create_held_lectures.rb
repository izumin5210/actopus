class CreateHeldLectures < ActiveRecord::Migration
  def change
    create_table :held_lectures do |t|
      t.integer :lecture_id, null: false
      t.integer :period_id, null: false
      t.integer :wday, null: false

      t.timestamps null: false
    end
    add_index :held_lectures, [:lecture_id, :period_id, :wday], unique: true
  end
end
