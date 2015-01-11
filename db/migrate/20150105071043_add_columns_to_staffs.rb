class AddColumnsToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :confirmation_token, :string
    add_column :staffs, :confirmed_at, :datetime
    add_column :staffs, :confirmation_sent_at, :datetime
    add_column :staffs, :unconfirmed_email, :string
    add_index :staffs, :confirmation_token, unique: true
  end
end
