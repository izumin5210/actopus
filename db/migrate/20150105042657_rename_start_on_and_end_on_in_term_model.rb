class RenameStartOnAndEndOnInTermModel < ActiveRecord::Migration
  def change
    rename_column :terms, :start_on, :started_on
    rename_column :terms, :end_on, :ended_on
  end
end
