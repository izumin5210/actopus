class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name, null: false
      t.string :begin_at, null: false
      t.string :end_at, null: false

      t.timestamps null: false
    end
    add_index :periods, :name, unique: true
    add_index :periods, [:begin_at, :end_at], unique: true
  end
end
