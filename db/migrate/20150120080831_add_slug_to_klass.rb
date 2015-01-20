class AddSlugToKlass < ActiveRecord::Migration
  def change
    add_column :klasses, :slug, :string
    add_index :klasses, :slug, unique: true
  end
end
