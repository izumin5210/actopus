class ModifyCategoryOfKlasses < ActiveRecord::Migration
  def change
    remove_column :klasses, :category
    add_column :klasses, :category, :integer
    add_index :klasses, :category
  end
end
