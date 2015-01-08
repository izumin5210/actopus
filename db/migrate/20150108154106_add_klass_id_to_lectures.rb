class AddKlassIdToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :klass_id, :integer
    add_index :lectures, :klass_id
  end
end
