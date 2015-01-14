class AddCodeToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :code, :string
    add_index :lectures, :code
  end
end
