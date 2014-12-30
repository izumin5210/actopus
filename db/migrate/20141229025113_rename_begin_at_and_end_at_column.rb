class RenameBeginAtAndEndAtColumn < ActiveRecord::Migration
  def change
    rename_column :periods, :begin_at, :start_time
    rename_column :periods, :end_at, :end_time
    rename_column :terms, :begin_at, :start_on
    rename_column :terms, :end_at, :end_on
    add_index :periods, :start_time
    add_index :periods, :end_time
    add_index :terms, :start_on
    add_index :terms, :end_on
  end
end
