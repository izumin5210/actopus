class ModifyCategoryOfKlasses < ActiveRecord::Migration
  def change
    change_column :klasses, :category, :integer, default: 0
    add_index :klasses, :category
  end
end
